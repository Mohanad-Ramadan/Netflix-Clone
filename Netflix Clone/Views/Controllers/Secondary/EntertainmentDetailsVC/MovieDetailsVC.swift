//
//  MovieDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class MovieDetailsVC: EntertainmentDetailsVC {
    override func viewDidLoad() {super.viewDidLoad(); configureMovieVC()}
    
    init(for movie: Entertainment, isTrend: Bool = false, rank: Int = 0) {
        super.init()
        self.movie = movie
        fetchData(isTrend: isTrend, rank: rank)

    }
    
    private func fetchData(isTrend: Bool, rank: Int) {
        Task {
            do {
                // get details
                let details: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: movie.id, ofType: "movie")
                
                let viewModel = MovieViewModel(title: details.title, overview: details.overview, genres: details.genres, mediaType: "movie" ,releaseDate: details.releaseDate, runtime: details.runtime )
                configureDetails(with: viewModel, isTrend: isTrend, rank: rank)
                
                // get cast
                let fetchedCast = try await NetworkManager.shared.getCastFor(mediaId: movie.id, ofType: "movie")
                let cast = fetchedCast.returnThreeCastSeperated(with: ", ")
                let director = fetchedCast.returnDirector()
                configureCast(with: MovieViewModel(cast: cast, director: director))
                
                // get trailers
                let trailers = try await NetworkManager.shared.getTrailersFor(mediaId: movie.id, ofType: "movie").returnYoutubeTrailers()
                configureTrailer(with: MovieViewModel(title: details.title ,videosResult: trailers))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Configure Movie VC
    func configureMovieVC() {
        [switchViewButtons, moreIdeasCollection, trailerTable].forEach {containterScrollView.addSubview($0)}
        configureParentVC()
        switchViewButtonsConstriants()
        switchViewButtons.firstApperanceAction()
        trailerTable.delegate = self
        trailerTable.dataSource = self
    }
    
    //MARK: - Videos Configuration
    private func getFirstTrailerName(from videosResult: [Trailer.Reuslts]) -> String {
        let trailerInfo = videosResult.filter { "Trailer".contains($0.type) }
        let trialerQuery = trailerInfo.map { $0.name }[0]
        return trialerQuery
    }
    
    func configureTrailer(with model: MovieViewModel){
        // Trailer Configuration
        guard let videosResult = model.videosResult else {return}
        guard let entertainmentName = model.title else {return}

        let trialerVideoQuery = "\(entertainmentName) \(getFirstTrailerName(from: videosResult))"

        Task {
            do {
                let trailerId = try await NetworkManager.shared.getTrailersIds(of: trialerVideoQuery)
                guard let url = URL(string: "https://www.youtube.com/embed/\(trailerId)") else {
                    fatalError("can't get the youtube trailer url")
                }
                self.entertainmentTrailer.load(URLRequest(url: url))
            } catch { print(error.localizedDescription) }
        }

        // pass th videos without the one taken for the entertainmentTrailer webView
        trailers = videosResult.filter { $0.name != getFirstTrailerName(from: videosResult) }
    }
    
    //MARK: - Configure constraints
    // Switch Buttons Constraints
    private func switchViewButtonsConstriants() {
        switchViewButtons.translatesAutoresizingMaskIntoConstraints = false
        switchViewButtons.topAnchor.constraint(equalTo: threeButtons.bottomAnchor, constant: 15).isActive = true
        switchViewButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        switchViewButtons.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
        switchViewButtons.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    //MARK: - Dynamic Constraints
    private func switchedViewsLayout(){
        // More CollectionView Constriants
        let moreIdeasCollectionConstriants = [
            moreIdeasCollection.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
            moreIdeasCollection.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            moreIdeasCollection.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5),
            moreIdeasCollection.heightAnchor.constraint(equalToConstant: 430),
            moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor)
        ]
        // Trailer TableView Constriants
        let trailerTableConstriants = [
            trailerTable.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor, constant: -35),
            trailerTable.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            trailerTable.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor,constant: -5),
            trailerTable.heightAnchor.constraint(equalToConstant: 290*3),
            trailerTable.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor)
        ]
        
        // Switching between views method
        switch switchViewButtons.selectedButtonView {
        case .moreIdeasView:
            // fade away the TableView from the SuperView
            UIView.animate(withDuration: 0.1) {
                self.trailerTable.alpha = 0
            } completion: { finished in
                    self.trailerTable.removeFromSuperview()
                    self.trailerTable.removeConstraints(trailerTableConstriants)
                    // Add the CollectionView to the superView
                    self.containterScrollView.addSubview(self.moreIdeasCollection)
                    NSLayoutConstraint.activate(moreIdeasCollectionConstriants)
                    UIView.animate(withDuration: 0.1) {self.moreIdeasCollection.alpha = 1}
            }

        case .trailerView:
            // fade away the CollectionView from the SuperView
            UIView.animate(withDuration: 0.1) {
                self.moreIdeasCollection.alpha = 0
            } completion: { finished in
                    self.moreIdeasCollection.removeFromSuperview()
                    self.moreIdeasCollection.removeConstraints(moreIdeasCollectionConstriants)
                    // Add the TableView to the superView
                    self.containterScrollView.addSubview(self.trailerTable)
                    NSLayoutConstraint.activate(trailerTableConstriants)
                    UIView.animate(withDuration: 0.1) {self.trailerTable.alpha = 1}
            }
            
        default:
            return
        }
    }
    
    override func applySwitchedViewsAndConstraints() {
        switchedViewsLayout()
        // Layout the views again
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.entertainmentVCKey), object: nil, queue: nil) { _ in
            self.switchedViewsLayout()
        }
    }
    
    //MARK: - Declare Movie Subviews
    private let switchViewButtons = SwitchViewButtonsUIView(buttonOneTitle: "More Like This", buttonTwoTitle: "Trailer & More")
    
    private let trailerTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TrailersTableViewCell.self, forCellReuseIdentifier: TrailersTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var trailers: [Trailer.Reuslts] = [Trailer.Reuslts]()
    var entertainmentName: String?
    var movie: Entertainment!
    
    required init?(coder: NSCoder) {fatalError()}
}




//MARK: - Delegate and DataSource
extension MovieDetailsVC: UITableViewDelegate,
                          UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailersTableViewCell.identifier, for: indexPath) as? TrailersTableViewCell else {
            return UITableViewCell()
        }
        
        let videoInfo = trailers[indexPath.row]
        guard let titleText = movie.title else {return UITableViewCell()}
        cell.configureCell(with: videoInfo, and: titleText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
}
