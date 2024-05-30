//
//  MovieDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class MovieDetailsVC: MediaDetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(isTrend: isTrend, rank: rank)
        configureMovieVC()
        saveToWatchedList(movie)
    }
    
    init(for movie: Media, isTrend: Bool = false, rank: Int = 0) {
        super.init()
        self.movie = movie
        self.isTrend = isTrend
        self.rank = rank
        // configure threeButton media
        threeButtons.media = movie
    }
    
    private func fetchData(isTrend: Bool, rank: Int) {
        Task {
            do {
                // get details
                let details: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: movie.id, ofType: "movie")
                let viewModel = MediaViewModel(title: details.title, overview: details.overview, genres: details.genres, mediaType: "movie" ,releaseDate: details.releaseDate, runtime: details.runtime )
                configureDetails(with: viewModel, isTrend: isTrend, rank: rank)
                
                // get cast
                let fetchedCast = try await NetworkManager.shared.getCastFor(mediaId: movie.id, ofType: "movie")
                configureCast(with: CastViewModel(fetchedCast))
                // configure castVC
                castData = fetchedCast
                
                // get trailers
                let fetchedTrailers = try await NetworkManager.shared.getTrailersFor(mediaId: movie.id, ofType: "movie").returnYoutubeTrailers()
                configureMovieTrailer(with: TrailerViewModel(fetchedTrailers))
                
            } catch {presentTemporaryAlert(alertType: .connectivity)}
        }
    }
    
    //MARK: - Configure Movie VC
    func configureMovieVC() {
        [switchViewButtons, moreIdeasCollection, trailerTable].forEach {containterScrollView.addSubview($0)}
        configureParentVC()
        
        switchViewButtonsConstriants()
        switchViewButtons.delegate = self
        switchViewButtons.triggerButtonOne()
        
        trailerTable.delegate = self
        trailerTable.dataSource = self
    }
    
    //MARK: - Trailer Configuration
    private func configureMovieTrailer(with trailers: TrailerViewModel){
        configureTrailer(with: trailers)
        self.moreTrailers = trailers.getSomeTrailers(withTotal: 4)
        // return the trailers count
        // if it less than the total passed in moreTrailers
        trailersCount = CGFloat(trailers.trailersCount ?? 0)
    }
    
    //MARK: - Configure constraints
    
    // Switch Buttons Constraints
    private func switchViewButtonsConstriants() {
        switchViewButtons.translatesAutoresizingMaskIntoConstraints = false
        switchViewButtons.topAnchor.constraint(equalTo: threeButtons.bottomAnchor, constant: 15).isActive = true
        switchViewButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        switchViewButtons.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
        switchViewButtons.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func moreIdeasCollectionConstriants() -> [NSLayoutConstraint] {
        [moreIdeasCollection.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
        moreIdeasCollection.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5),
        moreIdeasCollection.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5),
        moreIdeasCollection.heightAnchor.constraint(equalToConstant: 430),
        moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)]
    }
    
    private func trailerTableConstriants() -> [NSLayoutConstraint] {
        [trailerTable.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
         trailerTable.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5),
         trailerTable.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor,constant: -5),
         trailerTable.heightAnchor.constraint(equalToConstant: 300 * (trailersCount ?? 1)),
         trailerTable.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)]
    }
    
    //MARK: - Switch mainViews methods
    private func showMoreCollectionView() {
        UIView.animate(withDuration: 0.1) {
            self.trailerTable.alpha = 0
        } completion: { finished in
                self.trailerTable.removeFromSuperview()
            self.trailerTable.removeConstraints(self.trailerTableConstriants())
                // Add the CollectionView to the superView
                self.containterScrollView.addSubview(self.moreIdeasCollection)
            NSLayoutConstraint.activate(self.moreIdeasCollectionConstriants())
                UIView.animate(withDuration: 0.1) {self.moreIdeasCollection.alpha = 1}
        }
    }
    
    private func showTrailerTableView() {
        UIView.animate(withDuration: 0.1) {
            self.moreIdeasCollection.alpha = 0
        } completion: { finished in
                self.moreIdeasCollection.removeFromSuperview()
            self.moreIdeasCollection.removeConstraints(self.moreIdeasCollectionConstriants())
                // Add the TableView to the superView
                self.containterScrollView.addSubview(self.trailerTable)
            NSLayoutConstraint.activate(self.trailerTableConstriants())
                UIView.animate(withDuration: 0.1) {self.trailerTable.alpha = 1}
        }
    }
    
    
    //MARK: - Declare Variables
    private let switchViewButtons = SwitchViewButtonsUIView(buttonOneTitle: "More Like This", buttonTwoTitle: "Trailer & More")
    
    private let trailerTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(TrailersTableViewCell.self, forCellReuseIdentifier: TrailersTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.isSpringLoaded = true
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var moreTrailers: [Trailer.Reuslts] = [Trailer.Reuslts]()
    var mediaName: String?
    var movie: Media!
    var isTrend: Bool!
    var rank: Int!
    var trailersCount: CGFloat?
    
    required init?(coder: NSCoder) {fatalError()}
}

//MARK: - SwitchViw Buttons delegate
extension MovieDetailsVC: SwitchViewButtonsUIView.Delegate {
    func buttonOneAction() {showMoreCollectionView()}
    func buttonTwoAction() {showTrailerTableView()}
}



//MARK: - Trailers Delegate
extension MovieDetailsVC: UITableViewDelegate,
                          UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreTrailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailersTableViewCell.identifier, for: indexPath) as? TrailersTableViewCell else {
            return UITableViewCell()
        }
        
        let videoInfo = moreTrailers[indexPath.row]
        guard let titleText = movie.title else {return UITableViewCell()}
        cell.configureCell(with: videoInfo, and: titleText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
