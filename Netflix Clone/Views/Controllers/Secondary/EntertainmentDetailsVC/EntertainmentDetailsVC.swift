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
        
        [netflixLogo, categoryLabel, entertainmentTitle, detailsLabel, top10Logo, top10DetailsLabel, playButton, overViewLabel, castLabel, expandCastButton, directorLabel, threeButtons, viewSwitchButtons
        ].forEach {containterScrollView.addSubview($0)}
        
        moreIdeasCollection.delegate = self
        moreIdeasCollection.dataSource = self
        
        viewSwitchButtons.moreButtonTapped()
        
        applyConstraints()
    }
    
    //MARK: - Configure EntertainmentDetailsVC Method
    func configureCast(with model: MovieViewModel){
        castLabel.text = model.cast
        castLabel.lineBreakMode = .byTruncatingTail
        directorLabel.text = model.director
    }
    
    func configureDetails(with model: MovieViewModel, isTrending: Bool = false, rank: Int = 0){
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
        
        // fetch more entertainment with generes and mediatype
        var genresId: String? {
            let genres = model.genres?.prefix(2) ?? model.genres?.prefix(1)
            let genreId = genres?.map{String($0.id)}
            let stringIds = genreId?.joined(separator: ",")
            return stringIds
        }
        
        fetchMoreEntertainment(model.title! ,genresId: genresId, mediaType: model.mediaType ?? "no type found")
    }
    
    private func fetchMoreEntertainment(_ mainEntertainment: String ,genresId: String?, mediaType: String){
        Task{
            do {
                if let ids = genresId {
                    let entertainments = try await NetworkManager.shared.getMoreLike(genresId: ids, ofMediaType: mediaType)
                    let moreWithNoDuplicates = entertainments.filter{!mainEntertainment.contains($0.title!)}
                    moreEntertainments = moreWithNoDuplicates.prefix(6).shuffled()
                } else {
                    let entertainments = try await NetworkManager.shared.getDataOf( mediaType == "movie" ? .weekTrendingMovies : .weekTrendingTV)
                    let moreWithNoDuplicates = entertainments.filter{!mainEntertainment.contains($0.title!)}
                    moreEntertainments = moreWithNoDuplicates.prefix(6).shuffled()
                }
                moreIdeasCollection.reloadData()
            } catch let error as APIError {
//                presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                presentDefaultError()
                print(error.localizedDescription)
            }
        }
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
        expandCastButton.configuration?.contentInsets = .init(top: 0, leading: 2, bottom: 1, trailing: 0)
        expandCastButton.centerYAnchor.constraint(equalTo: castLabel.centerYAnchor).isActive = true
        expandCastButton.leadingAnchor.constraint(equalTo: castLabel.trailingAnchor).isActive = true
        expandCastButton.trailingAnchor.constraint(lessThanOrEqualTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
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
        
        // rearrange views depend on top10 layout (began from playButton View)
        playButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func applySwitchedViewsAndConstraints() {}
    
    //MARK: Apply constriants function
    func applyConstraints() {
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

    let entertainmentTrailer: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        return webView
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
    
    //MARK: - Declare Container Subviews
    
    private let netflixLogo = NFImageView(image: .netflixClone)
    
    private let categoryLabel = NFBodyLabel(color: .lightGray, fontSize: 10, fontWeight: .semibold)
    
    private let entertainmentTitle = NFBodyLabel(color: .white, fontSize: 21, fontWeight: .bold, lines: 0)
    
    private let detailsLabel = DetailsLabelUIView()
    
    private let top10Logo = NFImageView(image: .top10)
    
    private let top10DetailsLabel = NFBodyLabel(color: .white, fontSize: 17, fontWeight: .bold)
    
    private let playButton = NFFilledButton(title: "Play", image: UIImage(systemName: "play.fill"), fontSize: 18, fontWeight: .semibold)
    
    private let overViewLabel = NFBodyLabel(color: .white, fontSize: 15, lines: 0)
    
    private let castLabel = NFBodyLabel(color: .lightGray, fontSize: 12, fontWeight: .light)
    
    private let expandCastButton = NFPlainButton(title: "more",titleColor: .lightGray, fontSize: 12, fontWeight: .semibold)
    
    private let directorLabel = NFBodyLabel(color: .lightGray, fontSize: 12, fontWeight: .light)
    
    private let threeButtons = ThreeButtonUIView()
    
    let viewSwitchButtons = ViewSwitchButtonsUIView()
    
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
    
    var moreEntertainments: [Entertainment] = [Entertainment]()
    
}
