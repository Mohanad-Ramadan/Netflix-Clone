//
//  TvShowDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class TvShowDetailsVC: EntertainmentDetailsVC {
    override func viewDidLoad() {super.viewDidLoad(); configureTVShowVC()}
    
    init(for tvShow: Entertainment, isTrend: Bool = false, rank: Int = 0) {
        super.init()
        self.tvShow = tvShow
        fetchData(isTrend: isTrend, rank: rank)
        
    }
    
    private func fetchData(isTrend: Bool, rank: Int){
        Task {
            do {
                // get details
                let details: TVDetail = try await NetworkManager.shared.getDetailsFor(mediaId: tvShow.id, ofType: "tv")
                let viewModel = MovieViewModel(title: details.name, overview: details.overview, genres: details.genres, mediaType: "tv" ,releaseDate: details.lastAirDate)
                configureDetails(with: viewModel, isTrend: isTrend, rank: rank)
                
                // get cast
                let fetchedCast = try await NetworkManager.shared.getCastFor(mediaId: tvShow.id, ofType: "tv")
                let cast = fetchedCast.returnThreeCastSeperated(with: ", ")
                let director = fetchedCast.returnDirector()
                configureCast(with: MovieViewModel(cast: cast, director: director))
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Configure Movie VC
    func configureTVShowVC() {
        containterScrollView.addSubview(switchViewButtons)
        configureParentVC()
        switchViewButtonsConstriants()
        switchViewButtons.firstApperanceAction()
        episodeTable.delegate = self
        episodeTable.dataSource = self
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
        let episodeTableConstriants = [
            episodeTable.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
            episodeTable.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            episodeTable.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor,constant: -5),
            //fix
            episodeTable.heightAnchor.constraint(equalToConstant: 900),
            episodeTable.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor),
        ]
        
        // Switching between views method
        switch switchViewButtons.selectedButtonView {
        case .moreIdeasView:
            // Add the CollectionView to the superView
            containterScrollView.addSubview(moreIdeasCollection)
            NSLayoutConstraint.activate(moreIdeasCollectionConstriants)
            // fade away the TableView from the SuperView
            //fix
            episodeTable.removeFromSuperview()
            episodeTable.removeConstraints(episodeTableConstriants)
        case .trailerView:
            // Add the TableView to the superView
            containterScrollView.addSubview(episodeTable)
            NSLayoutConstraint.activate(episodeTableConstriants)
            // fade away the CollectionView from the SuperView
            //fix
            moreIdeasCollection.removeFromSuperview()
            moreIdeasCollection.removeConstraints(moreIdeasCollectionConstriants)
        default:
            return
        }
    }
    
    override func applySwitchedViewsAndConstraints() {
        //fix
        switchedViewsLayout()
        // Layout the views again
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.entertainmentVCKey), object: nil, queue: nil) { _ in
            self.switchedViewsLayout()
        }
    }
    
    //MARK: - Declare TvShows Subviews
    private let switchViewButtons = SwitchViewButtonsUIView(buttonOneTitle: "Episodes", buttonTwoTitle: "More Like This")
    
    private let stackContainer: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let episodeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var tvShow: Entertainment!
    var seasons: SeasonDetail!
    var episodes: [SeasonDetail.Episode]!
    
    required init?(coder: NSCoder) {fatalError()}
}


//MARK: - Delegate and DataSource
extension TvShowDetailsVC: UITableViewDelegate,
                          UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell else {
            return UITableViewCell()
        }
        
//        let videoInfo = trailers[indexPath.row]
//        guard let titleText = movie.title else {return UITableViewCell()}
//        cell.configureCell(with: videoInfo, and: titleText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .white
    }
}
