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
                
                // get seasons
//                let fetchedSeasons = try await NetworkManager.shared.getSeasonDetailsFor(seriesId: tvShow.id, seasonNum: 1)
//                episodes = fetchedSeasons.episodes
                print(tvShow.id)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Configure Movie VC
    func configureTVShowVC() {
        [switchViewButtons, moreIdeasCollection, episodesTable].forEach {containterScrollView.addSubview($0)}
        configureParentVC()
        
        switchViewButtonsConstriants()
        switchViewButtons.delegate = self
        switchViewButtons.triggerButtonOne()
        
        episodesTable.delegate = self
        episodesTable.dataSource = self
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
    
    private func moreIdeasCollectionConstriants() -> [NSLayoutConstraint] {
        [moreIdeasCollection.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
        moreIdeasCollection.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
        moreIdeasCollection.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5),
        moreIdeasCollection.heightAnchor.constraint(equalToConstant: 430),
        moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)]
    }
    
    private func episodesTableConstriants() -> [NSLayoutConstraint] {
        [episodesTable.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
         episodesTable.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
         episodesTable.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor,constant: -5),
         
         episodesTable.heightAnchor.constraint(equalToConstant: 250*3),
         episodesTable.widthAnchor.constraint(equalToConstant: view.bounds.width),
//         episodesTable.heightAnchor.constraint(equalToConstant: CGFloat(250 * episodes.count)),
         episodesTable.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)]
    }
    
    //MARK: - Switch mainViews methods
    private func showMoreCollectionView() {
        UIView.animate(withDuration: 0.1) {
            self.episodesTable.alpha = 0
        } completion: { finished in
            self.episodesTable.removeFromSuperview()
            self.episodesTable.removeConstraints(self.episodesTableConstriants())
            // Add the CollectionView to the superView
            self.containterScrollView.addSubview(self.moreIdeasCollection)
            NSLayoutConstraint.activate(self.moreIdeasCollectionConstriants())
            UIView.animate(withDuration: 0.1) {self.episodesTable.alpha = 1}
        }
    }
    
    private func showEpisodesTableView() {
        UIView.animate(withDuration: 0.1) {
            self.moreIdeasCollection.alpha = 0
        } completion: { finished in
            self.moreIdeasCollection.removeFromSuperview()
            self.moreIdeasCollection.removeConstraints(self.moreIdeasCollectionConstriants())
            // Add the CollectionView to the superView
            self.containterScrollView.addSubview(self.episodesTable)
            NSLayoutConstraint.activate(self.episodesTableConstriants())
            UIView.animate(withDuration: 0.1) {self.moreIdeasCollection.alpha = 1}
        }
    }
    
    //MARK: - Declare TvShows Subviews
    private let switchViewButtons = SwitchViewButtonsUIView(buttonOneTitle: "Episodes", buttonTwoTitle: "More Like This")
    
    private let episodesTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .clear
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


//MARK: - SwitchViw Buttons delegate
extension TvShowDetailsVC: SwitchViewButtonsUIView.Delegate {
    func buttonOneAction() {showEpisodesTableView()}
    func buttonTwoAction() {showMoreCollectionView()}
}


//MARK: - Delegate and DataSource
extension TvShowDetailsVC: UITableViewDelegate,
                          UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier, for: indexPath) as? EpisodesTableViewCell else {return UITableViewCell()}
//        let episode = episodes[indexPath.row]
//        cell.configureCellDetail(from: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
