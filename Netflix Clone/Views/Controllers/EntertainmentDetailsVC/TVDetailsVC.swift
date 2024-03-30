//
//  TVDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class TVDetailsVC: EntertainmentDetailsVC {
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
                seasonsCount = details.numberOfSeasons ?? 1
                let seasonDetials = try await NetworkManager.shared.getSeasonDetailsFor(seriesId: tvShow.id, seasonNumber: 1)
                episodes = seasonDetials.episodes
                updateEpisodesTable()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Configure Movie VC
    func configureTVShowVC() {
        [switchViewButtons, moreIdeasCollection, episodesTable].forEach {containterScrollView.addSubview($0)}
        configureParentVC()
        configureEpisodeTable()
        
        switchViewButtonsConstriants()
        switchViewButtons.delegate = self
        switchViewButtons.triggerButtonOne()
        
        
    }
    
    func configureEpisodeTable() {
        episodesTable.delegate = self
        episodesTable.dataSource = self
        episodeTableHeaderView.delegate = self
        
        episodeTableHeaderView.frame = CGRect(x: 0, y: 0, width: episodesTable.bounds.width, height: 30)
        episodesTable.tableHeaderView = episodeTableHeaderView
    }
    
    func updateEpisodesTable() {
        episodesCount = episodes.count
        episodesTable.reloadData()
        episodesTable.heightAnchor.constraint(equalToConstant: 190 * CGFloat(self.episodesCount!)).isActive = true
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
         moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)
        ]
    }
    
    private func episodesTableConstriants() -> [NSLayoutConstraint] {
        [episodesTable.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
         episodesTable.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
         episodesTable.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5),
         episodesTable.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)
        ]
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
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let episodeTableHeaderView = SeasonSelectHeaderView()
    
    var tvShow: Entertainment!
    var seasons: SeasonDetail?
    var seasonsCount: Int!
    var episodes: [SeasonDetail.Episode] = []
    var episodesCount: Int?
    
    required init?(coder: NSCoder) {fatalError()}
}


//MARK: - Subviews Delegates
extension TVDetailsVC: SwitchViewButtonsUIView.Delegate {
    func buttonOneAction() {showEpisodesTableView()}
    func buttonTwoAction() {showMoreCollectionView()}
}

extension TVDetailsVC: SeasonSelectHeaderView.Delegate {
    func listButtonTapped() {
        let seasonListVC = SeasonsListVC(seasonsCount: seasonsCount)
        seasonListVC.delegate = self
        presentInMainThread(seasonListVC)
    }
}

extension TVDetailsVC: SeasonsListVC.Delegate {
    func selectSeason(number seasonNumber: Int) {
        Task {
            let seasonDetials = try await NetworkManager.shared.getSeasonDetailsFor(seriesId: tvShow.id, seasonNumber: seasonNumber)
            episodes = seasonDetials.episodes
            updateEpisodesTable()
        }
    }
}

//MARK: - Delegate and DataSource
extension TVDetailsVC: UITableViewDelegate,
                           UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return episodes.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier, for: indexPath) as? EpisodesTableViewCell else {return UITableViewCell()}
        let episode = episodes[indexPath.row]
        cell.configureCellDetail(from: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
