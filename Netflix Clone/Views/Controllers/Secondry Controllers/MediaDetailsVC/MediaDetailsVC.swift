//
//  MediaDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 21/01/2024.
//

import UIKit
import YouTubePlayerKit
import Combine
import SkeletonView

class MediaDetailsVC: UIViewController {
    
    //MARK: Declare Variables
    
    // Declare Main Views
    lazy var youtubePlayerVC: YouTubePlayerViewController = {
        let youtubeVC = YouTubePlayerViewController()
        youtubeVC.view.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .fadedBlack)
        youtubeVC.view.showAnimatedGradientSkeleton(usingGradient: gradient)
        return youtubeVC
    }()
    
    
    let containterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //Declare Container Subviews
    let netflixLogo = NFImageView(image: .netflixIcon)
    
    let categoryLabel = NFBodyLabel(color: .lightGray, fontSize: 10, fontWeight: .semibold)
    
    let mediaTitle = NFBodyLabel(color: .white, fontSize: 21, fontWeight: .bold, lines: 0)
    
    let detailsLabel = DetailsLabelUIView()
    
    let top10Logo = NFImageView(image: .top10)
    
    let top10DetailsLabel = NFBodyLabel(color: .white, fontSize: 17, fontWeight: .bold)
    
    let playButton = NFFilledButton(title: "Play", image: UIImage(systemName: "play.fill"), fontSize: 18, fontWeight: .semibold)
    
    let overViewLabel = NFBodyLabel(color: .white, fontSize: 15, lines: 0)
    
    let castLabel = NFBodyLabel(color: .lightGray, fontSize: 12, fontWeight: .light)
    
    let castExpandButton = NFPlainButton(title: "...more", buttonColor: .lightGray, fontSize: 12, fontWeight: .semibold)
    
    let directorLabel = NFBodyLabel(color: .lightGray, fontSize: 12, fontWeight: .light)
    
    let threeButtons = ThreeButtonsUIView()
    
    let moreIdeasCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3)-8, height: 185)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var moreMedias: [Media] = [Media]()
    var castData: Cast?
    var currentTrailerTime: AnyCancellable?
    var trailerDurationTime: AnyCancellable?
    

    //MARK: - Load View
    override func viewDidLoad() {super.viewDidLoad()}
    
    init() {super.init(nibName: nil, bundle: nil)}
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Configure VC
    func configureParentVC() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        
        // configure the youtube vc in parentVC
        UIHelper.setupChildVC(from: youtubePlayerVC, in: self)
        view.addSubview(containterScrollView)
        
        [netflixLogo, categoryLabel, mediaTitle, detailsLabel, playButton, overViewLabel, castLabel, castExpandButton, directorLabel, threeButtons].forEach {containterScrollView.addSubview($0)}
        
        moreIdeasCollection.delegate = self
        moreIdeasCollection.dataSource = self
        threeButtons.delegate = self
        
        configureCastButton()
        applyConstraints()
    }
    

    //MARK: - Setup Views
    func configureCast(with cast: CastViewModel){
        castLabel.text = cast.getSomeActros(totalActors: 3, seperator: ", ")
        castLabel.lineBreakMode = .byTruncatingTail
        directorLabel.text = cast.directors
    }
    
    func configureDetails(with details: DetailsViewModel, isTrend: Bool = false, rank: Int = 0){
        mediaTitle.text = details.title
        overViewLabel.text = details.overview
        categoryLabel.text = details.mediaTypeLabel
        // details label UIView configuration
        detailsLabel.newLabel.text = details.newLabel
        detailsLabel.dateLabel.text = details.dateLabel
        detailsLabel.runtimeLabel.text = details.runtime
        // Trending condition for Top10LogoView
        setupTop10Logo(isTrend: isTrend)
        top10DetailsLabel.text = isTrend ? "#\(rank) in \(details.rankTypeLabel) Today" : nil
        // fetch More Media dataSource
        guard details.title != nil, details.mediaType != nil else {return}
        fetchMoreMediaFor(mediaTitle: details.title!, genresId: details.genresIds, mediaType: details.mediaType!)
    }
    
    // configure button action
    func configureCastButton() {
        castExpandButton.addTarget(self, action: #selector(goToCastListVC), for: .touchUpInside)
    }
    
    @objc func goToCastListVC() {
        let castVC = CastListVC()
        castVC.cast = castData
        presentInMainThread(castVC)
    }
    
    //MARK: - Trailers Configurations
    func configureTrailer(with trailers: TrailerViewModel){
        Task {
            try? await self.youtubePlayerVC.player.load(source: .video(id: trailers.firstTrailerKey))
            try? await self.youtubePlayerVC.player.update(configuration: .init(fullscreenMode: .system,openURLAction: .init(handler: { _ in }),autoPlay: true,showCaptions: true))
            youtubePlayerVC.view.hideSkeleton()
        }
    }
    
    // add the media to watched trailer list
    // if it exceeds 50% of the trailer
    func saveToWatchedList(_ item: Media?) {
        guard let item else {return}
        trailerDurationTime = youtubePlayerVC.player.durationPublisher
            .sink{ duration in
                self.currentTrailerTime = self.youtubePlayerVC.player.currentTimePublisher()
                    .sink { currentTime in
                        if currentTime >= duration*0.5 {
                            self.addMedia(item: item)
                            self.currentTrailerTime?.cancel()
                            self.trailerDurationTime?.cancel()
                        }
                    }
            }
    }
    
    func addMedia(item: Media) {
        Task {
            try await PersistenceDataManager.shared.saveWatchedItem(item)
            NotificationCenter.default.post(name: NSNotification.Name(NotificationKey.trailersKey), object: nil)
        }
    }
    
    //MARK: - MoreIdeas Data Fetching
    private func fetchMoreMediaFor(mediaTitle mainMedia: String ,genresId: String?, mediaType: String){
        Task{
            do {
                guard let ids = genresId else {return}
                let media = try await NetworkManager.shared.getMoreOf(genresId: ids, ofMediaType: mediaType)
                let removeDuplicate = media.filter{!mainMedia.contains(mediaType == "movie" ? $0.title ?? "no duplicate": $0.originalName ?? "no duplicate")}
                let shuffledMedia = removeDuplicate.shuffled()
                moreMedias = Array(shuffledMedia.prefix(6))
                moreIdeasCollection.reloadData()
            } catch let error as APIError {
                presentNFAlert(messageText: error.rawValue)
            } catch {
                presentTemporaryAlert(alertType: .connectivity)
            }
        }
    }
    
    
    //MARK: - Main Views constraints
    
    // Trailer Video
    private func trailerVideoConstraints() {
        youtubePlayerVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        youtubePlayerVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        youtubePlayerVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        youtubePlayerVC.view.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    // ScrollView Constraints
    private func scrollViewConstriants() {
        containterScrollView.topAnchor.constraint(equalTo: youtubePlayerVC.view.bottomAnchor, constant: 10).isActive = true
        containterScrollView.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        containterScrollView.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
        containterScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: -  SubViews constraints
    
    // Netflixlogo + CategoryLabel Constraints
    private func neflixlogoAndGenresLabelConstriants() {
        netflixLogo.topAnchor.constraint(equalTo: containterScrollView.contentLayoutGuide.topAnchor).isActive = true
        netflixLogo.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor).isActive = true
        netflixLogo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        netflixLogo.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        categoryLabel.centerYAnchor.constraint(equalTo: netflixLogo.centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: netflixLogo.trailingAnchor).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // Title Constraints
    private func mediaTitleConstriants() {
        mediaTitle.topAnchor.constraint(equalTo: netflixLogo.bottomAnchor).isActive = true
        mediaTitle.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        mediaTitle.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // Details Label Constraints
    private func detailsLabelConstriants() {
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.topAnchor.constraint(equalTo: mediaTitle.bottomAnchor).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        detailsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // View based on Category Constriants
    private func setupTop10Logo(isTrend: Bool) {
        if isTrend {
            view.addSubview(top10Logo)
            view.addSubview(top10DetailsLabel)
            
            view.sendSubviewToBack(top10DetailsLabel)
            view.sendSubviewToBack(top10Logo)
            
            top10Logo.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor).isActive = true
            top10Logo.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor).isActive = true
            top10Logo.heightAnchor.constraint(equalToConstant: 35).isActive = true
            top10Logo.widthAnchor.constraint(equalToConstant: 35).isActive = true
            
            top10DetailsLabel.centerYAnchor.constraint(equalTo: top10Logo.centerYAnchor).isActive = true
            top10DetailsLabel.leadingAnchor.constraint(equalTo: top10Logo.trailingAnchor).isActive = true
            top10DetailsLabel.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
            
            playButton.removeConstraint(playButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5))
            playButton.topAnchor.constraint(equalTo: top10Logo.bottomAnchor, constant: 5).isActive = true
        } else {
            top10Logo.removeFromSuperview()
            top10DetailsLabel.removeFromSuperview()
        }
    }
    
    
    // Details Label Constraints
    private func playButtonConstriants() {
        playButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5).isActive = true
        playButton.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        playButton.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // OverView Label Constraints
    private func overViewLabelConstriants() {
        overViewLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 15).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // Cast Label Constraints
    private func castLabelConstriants() {
        castLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 10).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        castLabel.widthAnchor.constraint(equalTo: castLabel.widthAnchor).isActive = true
    }
    
    // Expand cast button Constraints
    private func expandCastButtonConstriants() {
        castExpandButton.configuration?.contentInsets = .init(top: 0, leading: 2, bottom: 1, trailing: 0)
        castExpandButton.centerYAnchor.constraint(equalTo: castLabel.centerYAnchor).isActive = true
        castExpandButton.leadingAnchor.constraint(equalTo: castLabel.trailingAnchor).isActive = true
        castExpandButton.trailingAnchor.constraint(lessThanOrEqualTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }

    
    // Director Label Constriatns
    private func directorLabelConstriants() {
        directorLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 5).isActive = true
        directorLabel.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        directorLabel.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // Three Buttons Constraints
    private func threeButtonsConstriants() {
        threeButtons.translatesAutoresizingMaskIntoConstraints = false
        threeButtons.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 5).isActive = true
        threeButtons.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor, constant: 5).isActive = true
        threeButtons.trailingAnchor.constraint(equalTo: youtubePlayerVC.view.trailingAnchor, constant: -5).isActive = true
        threeButtons.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    
    func applySwitchedViewsAndConstraints() {}
    
    //MARK: Apply Constriants
    func applyConstraints() {
        trailerVideoConstraints()
        scrollViewConstriants()
        neflixlogoAndGenresLabelConstriants()
        mediaTitleConstriants()
        detailsLabelConstriants()
        playButtonConstriants()
        overViewLabelConstriants()
        castLabelConstriants()
        expandCastButtonConstriants()
        directorLabelConstriants()
        threeButtonsConstriants()
        applySwitchedViewsAndConstraints()
    }

}


//MARK: - CollectionView Delegate
extension MediaDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreMedias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let poster = moreMedias[indexPath.row].posterPath ?? ""
        cell.configureCell(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = moreMedias[indexPath.row]
        
        if media.title != nil {
            let vc = MovieDetailsVC(for: media)
            pushInMainThreadTo(vc)
        } else if media.originalName != nil {
            let vc = TVDetailsVC(for: media)
            pushInMainThreadTo(vc)
        }
    }
    
}

//MARK: - ThreeButtons Delegate
extension MediaDetailsVC: ThreeButtonsUIView.Delegate{
    func saveMediaToList() {presentTemporaryAlert(alertType: .save)}
    func removeMediafromList() {presentTemporaryAlert(alertType: .remove)}
}
