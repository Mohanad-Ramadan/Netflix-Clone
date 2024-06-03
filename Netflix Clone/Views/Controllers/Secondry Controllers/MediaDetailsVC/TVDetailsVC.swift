//
//  TVDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class TVDetailsVC: MediaDetailsVC {
    
    //MARK: Declare Variables
    private let episodesContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let episodesHeaderView = SeasonSelectHeaderView()
    
    var tvShow: Media?
    var isTrend: Bool = false
    var rank: Int?
    var seasons: SeasonDetail?
    var seasonsCount: Int?
    var episodes: [SeasonDetail.Episode] = []
    var episodesCount: Int?
    var currentSeason = 1
    
    
    //MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(isTrend: isTrend, rank: rank ?? 0)
        configureTVShowVC()
        saveToWatchedList(tvShow)
    }
    
    init(for tvShow: Media, isTrend: Bool = false, rank: Int = 0) {
        super.init()
        self.tvShow = tvShow
        self.isTrend = isTrend
        self.rank = rank
        // configure threeButton media
        threeButtons.media = tvShow
    }
    
    //MARK: - Fetch Data
    private func fetchData(isTrend: Bool, rank: Int){
        
        Task {
            do {
                guard let tvShow else {throw APIError.unableToComplete}
                // get details
                let details: TVDetail = try await NetworkManager.shared.getDetailsFor(mediaId: tvShow.id, ofType: "tv")
                configureDetails(with: DetailsViewModel(details), isTrend: isTrend, rank: rank)
                
                // get seasons
                seasonsCount = details.numberOfSeasons ?? 1
                let seasonDetials = try await NetworkManager.shared.getSeasonDetailsFor(seriesId: tvShow.id, seasonNumber: 1)
                episodes = seasonDetials.episodes
                updateEpisodesTable()
                
                // get cast
                let fetchedCast = try await NetworkManager.shared.getCastFor(mediaId: tvShow.id, ofType: "tv")
                configureCast(with: CastViewModel(fetchedCast))
                // configure castVC
                castData = fetchedCast
                
                // get trailers
                let fetchedTrailers = try await NetworkManager.shared.getTrailersFor(mediaId: tvShow.id, ofType: "tv")
                configureTrailer(with: TrailerViewModel(fetchedTrailers))
                
            } catch let error as APIError {
                presentNFAlert(messageText: error.rawValue)
            } catch {
                presentTemporaryAlert(alertType: .connectivity)
            }
        }
    }
    
    //MARK: - Setup Views
    func configureTVShowVC() {
        [switchViewButtons, episodesContainerView, moreIdeasCollection].forEach {containterScrollView.addSubview($0)}
        
        configureEpisodeContainer()
        configureParentVC()
        
        switchViewButtonsConstriants()
        switchViewButtons.delegate = self
        switchViewButtons.triggerButtonOne()
    }
    
    func configureEpisodeContainer() {
        [episodesHeaderView, episodesTable].forEach {episodesContainerView.addSubview($0)}
        episodesTable.delegate = self
        episodesTable.dataSource = self
        episodesHeaderView.translatesAutoresizingMaskIntoConstraints = false
        episodesHeaderView.delegate = self
    }
    
    func updateEpisodesTable() {
        episodesCount = episodes.count
        episodesTable.reloadData()
        episodesTable.heightAnchor.constraint(equalToConstant: 190 * CGFloat(self.episodesCount!)).isActive = true
    }
    
    //MARK: - Constraints
    
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
         moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor)
        ]
    }
    
    private func episodesContainerConstriants() -> [NSLayoutConstraint] {
        [
            episodesContainerView.topAnchor.constraint(equalTo: switchViewButtons.bottomAnchor),
            episodesContainerView.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5),
            episodesContainerView.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5),
            episodesContainerView.bottomAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.bottomAnchor),
            
            episodesHeaderView.topAnchor.constraint(equalTo: episodesContainerView.topAnchor),
            episodesHeaderView.leadingAnchor.constraint(equalTo: episodesContainerView.leadingAnchor),
            episodesHeaderView.trailingAnchor.constraint(equalTo: episodesContainerView.trailingAnchor),
            episodesHeaderView.heightAnchor.constraint(equalToConstant: 30),
            
            episodesTable.topAnchor.constraint(equalTo: episodesHeaderView.bottomAnchor),
            episodesTable.leadingAnchor.constraint(equalTo: episodesContainerView.leadingAnchor),
            episodesTable.trailingAnchor.constraint(equalTo: episodesContainerView.trailingAnchor),
            episodesTable.bottomAnchor.constraint(equalTo: episodesContainerView.bottomAnchor)
        ]
    }
    
    //MARK: - Main Views Switching
    private func showMoreCollectionView() {
        UIView.animate(withDuration: 0.1) {
            self.episodesContainerView.alpha = 0
        } completion: { finished in
            self.episodesContainerView.removeFromSuperview()
            self.episodesContainerView.removeConstraints(self.episodesContainerConstriants())
            // Add the CollectionView to the superView
            self.containterScrollView.addSubview(self.moreIdeasCollection)
            NSLayoutConstraint.activate(self.moreIdeasCollectionConstriants())
            UIView.animate(withDuration: 0.1) {self.episodesContainerView.alpha = 1}
        }
    }
    
    private func showEpisodesTableView() {
        UIView.animate(withDuration: 0.1) {
            self.moreIdeasCollection.alpha = 0
        } completion: { finished in
            self.moreIdeasCollection.removeFromSuperview()
            self.moreIdeasCollection.removeConstraints(self.moreIdeasCollectionConstriants())
            // Add the CollectionView to the superView
            self.containterScrollView.addSubview(self.episodesContainerView)
            NSLayoutConstraint.activate(self.episodesContainerConstriants())
            UIView.animate(withDuration: 0.1) {self.moreIdeasCollection.alpha = 1}
        }
    }
    
    required init?(coder: NSCoder) {fatalError()}
}


//MARK: - Subviews Delegates
extension TVDetailsVC: SwitchViewButtonsUIView.Delegate {
    func buttonOneAction() {showEpisodesTableView()}
    func buttonTwoAction() {showMoreCollectionView()}
}

extension TVDetailsVC: SeasonSelectHeaderView.Delegate {
    func listButtonTapped() {
        let seasonListVC = SeasonsListVC(seasonsCount: seasonsCount ?? 1, currentSeason: currentSeason )
        seasonListVC.delegate = self
        presentInMainThread(seasonListVC)
    }
}

extension TVDetailsVC: SeasonsListVC.Delegate {
    func selectSeason(number seasonNumber: Int) {
        Task {
            guard let tvShow else {return}
            currentSeason = seasonNumber
            episodesHeaderView.seasonLabel.text = "Season \(seasonNumber)"
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
        return 170
    }
}
