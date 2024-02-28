//
//  EntertainmentDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 21/01/2024.
//

import UIKit
import WebKit

class EntertainmentDetailsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(entertainmentTrailer)
        view.addSubview(containterScrollView)
        
        [
            netflixLogo,
            categoryLabel,
            entertainmentTitle,
            detailsLabel,
            top10Logo,
            top10DetailsLabel,
            playButton,
            overViewLabel,
            castLabel,
            expandCastButton,
            directorLabel,
            threeButtons,
            viewSwitchButtons
            
        ].forEach {containterScrollView.addSubview($0)}
        
        moreIdeasCollection.delegate = self
        moreIdeasCollection.dataSource = self
        
        trailerTable.delegate = self
        trailerTable.dataSource = self
        
        viewSwitchButtons.moreButtonTapped()
        
        fetchMoreEntertainment()
        
        layoutViews()
    }
    
    private func fetchMoreEntertainment(){
        NetworkManager.shared.getTrending { [weak self] results in
            switch results {
            case .success(let entertainments):
                self?.moreEntertainments = entertainments.prefix(6).shuffled()
                DispatchQueue.main.async {
                    self?.moreIdeasCollection.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - delete when finished developing the VC and replace method callers for this one
    public func configureVCDetails(with model: MovieViewModel){
        entertainmentTitle.text = model.title
        overViewLabel.text = model.overview
    }
    
    //MARK: - Configure EntertainmentDetailsVC Method
    public func configureDetails(with model: MovieViewModel, isTrending: Bool, rank: Int){
        entertainmentTitle.text = model.title
        overViewLabel.text = model.overview
        categoryLabel.text = model.mediaType == "movie" ? "F I L M" : "S E R I E S"
        
        // details label UIView configuration
        detailsLabel.newLabel.text = model.releaseDate?.isNewRelease() ?? false ? "New" : String()
        detailsLabel.dateLabel.text = model.releaseDate?.extract().year
        detailsLabel.runtimeLabel.text = model.runtime?.formatTimeFromMinutes()
        
        // If entertainment is trending
        if isTrending == false {
            removeTop10RowView()
        } else {
            let rank = rank
            let mediaCategory = model.mediaType == "movie" ? "Movies" : "Tv Shows"
            top10DetailsLabel.text = "#\(rank) in \(mediaCategory) Today"
        }
        
        // pass the entertainment to trailer tableView cell
        entertainmentName = model.title
    }
    
    public func configureCast(with model: MovieViewModel){
        castLabel.text = model.cast
        directorLabel.text = model.director
    }
    
    
    //MARK: - Videos Configuration
    private func getFirstTrailerName(from videosResult: [Trailer.Reuslts]) -> String {
        let trailerInfo = videosResult.filter { "Trailer".contains($0.type) }
        let trialerQuery = trailerInfo.map { $0.name }[0]
        return trialerQuery
    }
    
    public func configureVideos(with model: MovieViewModel){
        // Trailer Configuration
        guard let videosResult = model.videosResult else {return}
        guard let entertainmentName = model.title else {return}
        
        let trialerVideoQuery = "\(entertainmentName) \(getFirstTrailerName(from: videosResult))"
        
        NetworkManager.shared.getYoutubeVideos(query: trialerVideoQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let videoId):
                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else {
                        fatalError("can't get the youtube trailer url")
                    }
                    self.entertainmentTrailer.load(URLRequest(url: url))
                case .failure(let failure):
                    print("Error getting Trailer video:", failure)
                }
            }
        }

        // pass th videos without the one taken for the entertainmentTrailer webView
        trailers = videosResult.filter { $0.name != getFirstTrailerName(from: videosResult) }
        trailerVideosCount = trailers.count
        
    }
    
    //MARK: - Main Views constraints
    
    // Trailer Video
    private func trailerVideoConstraints() {
        entertainmentTrailer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        entertainmentTrailer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        entertainmentTrailer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        entertainmentTrailer.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // ScrollView Constraints
    private func scrollViewConstriants() {
        containterScrollView.topAnchor.constraint(equalTo: entertainmentTrailer.bottomAnchor, constant: 10).isActive = true
        containterScrollView.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        containterScrollView.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
        containterScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: -  SubViews constraints
    
    // Netflixlogo + CategoryLabel Constraints
    private func neflixlogoAndGenresLabelConstriants() {
        netflixLogo.topAnchor.constraint(equalTo: containterScrollView.topAnchor).isActive = true
        netflixLogo.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor).isActive = true
        netflixLogo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        netflixLogo.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        categoryLabel.centerYAnchor.constraint(equalTo: netflixLogo.centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: netflixLogo.trailingAnchor).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // Title Constraints
    private func entertainmentTitleConstriants() {
        entertainmentTitle.topAnchor.constraint(equalTo: netflixLogo.bottomAnchor).isActive = true
        entertainmentTitle.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        entertainmentTitle.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // Details Label Constraints
    private func detailsLabelConstriants() {
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.topAnchor.constraint(equalTo: entertainmentTitle.bottomAnchor).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        detailsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // View based on Category Constriants
    private func top10LogoAndDetailsConstraints() {
        top10Logo.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor).isActive = true
        top10Logo.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor).isActive = true
        top10Logo.heightAnchor.constraint(equalToConstant: 35).isActive = true
        top10Logo.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        top10DetailsLabel.centerYAnchor.constraint(equalTo: top10Logo.centerYAnchor).isActive = true
        top10DetailsLabel.leadingAnchor.constraint(equalTo: top10Logo.trailingAnchor).isActive = true
        top10DetailsLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // Details Label Constraints
    private func playButtonConstriants() {
        playButton.topAnchor.constraint(equalTo: top10Logo.bottomAnchor, constant: 5).isActive = true
        playButton.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        playButton.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // OverView Label Constraints
    private func overViewLabelConstriants() {
        overViewLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 15).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // Cast Label Constraints
    private func castLabelConstriants() {
        castLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 10).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        castLabel.widthAnchor.constraint(equalTo: castLabel.widthAnchor).isActive = true
    }
    
    // Expand cast button Constraints
    private func expandCastButtonConstriants() {
        expandCastButton.centerYAnchor.constraint(equalTo: castLabel.centerYAnchor).isActive = true
        expandCastButton.leadingAnchor.constraint(equalTo: castLabel.trailingAnchor).isActive = true
    }

    
    // Director Label Constriatns
    private func directorLabelConstriants() {
        directorLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 5).isActive = true
        directorLabel.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        directorLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // Three Buttons Constraints
    private func threeButtonsConstriants() {
        threeButtons.translatesAutoresizingMaskIntoConstraints = false
        threeButtons.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 5).isActive = true
        threeButtons.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        threeButtons.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
        threeButtons.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // Table Switch Buttons Constraints
    private func viewSwitchButtonsConstriants() {
        viewSwitchButtons.translatesAutoresizingMaskIntoConstraints = false
        viewSwitchButtons.topAnchor.constraint(equalTo: threeButtons.bottomAnchor, constant: 15).isActive = true
        viewSwitchButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewSwitchButtons.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
        viewSwitchButtons.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }

    
    // CollectionView and TableView Constriants and layout
    private func switchedViewsLayout(){
        // More CollectionView Constriants
        let moreIdeasCollectionConstriants = [
            moreIdeasCollection.topAnchor.constraint(equalTo: viewSwitchButtons.bottomAnchor),
            moreIdeasCollection.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            moreIdeasCollection.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5),
            moreIdeasCollection.heightAnchor.constraint(equalToConstant: 430),
            moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor)
        ]
        // Trailer TableView Constriants
        let trailerTableConstriants = [
            trailerTable.topAnchor.constraint(equalTo: viewSwitchButtons.bottomAnchor),
            trailerTable.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            trailerTable.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor,constant: -5),
            trailerTable.heightAnchor.constraint(equalToConstant: 290*CGFloat(trailerVideosCount ?? 0)),
            trailerTable.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor),
        ]
        
        // Switching between views method
        switch viewSwitchButtons.selectedButtonView {
        case .moreIdeasView:
            // Add the CollectionView to the superView
            containterScrollView.addSubview(moreIdeasCollection)
            NSLayoutConstraint.activate(moreIdeasCollectionConstriants)
            // Remove the TableView from the SuperView
            trailerTable.removeFromSuperview()
            trailerTable.removeConstraints(moreIdeasCollectionConstriants)
        case .trailerView:
            // Add the TableView to the superView
            containterScrollView.addSubview(trailerTable)
            NSLayoutConstraint.activate(trailerTableConstriants)
            // Remove the TableView from the SuperView
            moreIdeasCollection.removeFromSuperview()
            moreIdeasCollection.removeConstraints(trailerTableConstriants)
        default:
            return
        }
    }
    
    // remove top10Row view if entertainment tapped is not trending
    func removeTop10RowView(){
        // remove the top10 row view
        top10DetailsLabel.removeFromSuperview()
        top10DetailsLabel.removeConstraints([
            top10DetailsLabel.centerYAnchor.constraint(equalTo: top10Logo.centerYAnchor),
            top10DetailsLabel.leadingAnchor.constraint(equalTo: top10Logo.trailingAnchor, constant: 5),
            top10DetailsLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5)
        ])
        top10Logo.removeFromSuperview()
        top10Logo.removeConstraints([
            top10Logo.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor),
            top10Logo.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor),
            top10Logo.heightAnchor.constraint(equalToConstant: 35),
            top10Logo.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        // remake the constraints of views depend on top10 layout (playButton View)
        playButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    private func applySwitchedViewsAndConstraints() {
        switchedViewsLayout()
        // Layout the views again
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.entertainmentVCKey), object: nil, queue: nil) { _ in
            self.switchedViewsLayout()
        }
    }
    
    //MARK: Apply constriants function
    private func layoutViews() {
        trailerVideoConstraints()
        scrollViewConstriants()
        neflixlogoAndGenresLabelConstriants()
        entertainmentTitleConstriants()
        detailsLabelConstriants()
        top10LogoAndDetailsConstraints()
        playButtonConstriants()
        overViewLabelConstriants()
        castLabelConstriants()
        expandCastButtonConstriants()
        directorLabelConstriants()
        threeButtonsConstriants()
        viewSwitchButtonsConstriants()
        applySwitchedViewsAndConstraints()
    }
    
    
    //MARK: - Declare Main Views
    
    private let entertainmentTrailer: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        return webView
    }()
    
    
    private let containterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - Declare Container Subviews
    
    private let netflixLogo = NFImageView(image: .netflixClone)
    
    private let categoryLabel = NFBodyLabel(color: .lightGray, fontSize: 10, fontWeight: .semibold)
    
    private let entertainmentTitle = NFBodyLabel(color: .white, fontSize: 21, fontWeight: .bold, lines: 0)
    
    private let detailsLabel = DetailsLabelUIView()
    
    private let top10Logo = NFImageView(image: .top10)
    
    private let top10DetailsLabel = NFBodyLabel(color: .white, fontSize: 17, fontWeight: .bold)
    
    private let playButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Play"
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(systemName: "play.fill")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.cornerStyle = .small
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let overViewLabel = NFBodyLabel(color: .white, fontSize: 15, lines: 0)
    
    private let castLabel = NFBodyLabel(color: .lightGray, fontSize: 12, fontWeight: .light)
    
    private let expandCastButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = " ... more"
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .lightGray
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            return outgoing
        }
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let directorLabel = NFBodyLabel(color: .lightGray, fontSize: 12, fontWeight: .light)
    
    private let threeButtons = ThreeButtonUIView()
    
    private let viewSwitchButtons = ViewSwitchButtonsUIView()
    
    private let moreIdeasCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3)-8, height: 185)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var moreEntertainments: [Entertainment] = [Entertainment]()
    
    private let trailerTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TrailersTableViewCell.self, forCellReuseIdentifier: TrailersTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    var trailers: [Trailer.Reuslts] = [Trailer.Reuslts]()
    
    var trailerVideosCount: Int?
    var entertainmentName: String?
    
}
