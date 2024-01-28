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
            categoryLogo,
            categoryDetailsLabel,
            playButton,
            overViewLabel,
            castLabel,
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
        APICaller.shared.getTrending { [weak self] results in
            switch results {
            case .success(let entertainments):
                self?.moreEntertainments = entertainments
                DispatchQueue.main.async {
                    self?.moreIdeasCollection.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Configure EntertainmentDetailsVC Method
    public func configureVCDetails(with model: MovieInfoViewModel){
        entertainmentTitle.text = model.title
        overViewLabel.text = model.titleOverview

//        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else {
//            fatalError("can't get the youtube trailer url")
//        }

//        webView.load(URLRequest(url: url))
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
        netflixLogo.heightAnchor.constraint(equalTo: netflixLogo.heightAnchor).isActive = true
        netflixLogo.widthAnchor.constraint(equalTo: netflixLogo.widthAnchor).isActive = true
        
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
        detailsLabel.topAnchor.constraint(equalTo: entertainmentTitle.bottomAnchor, constant: 8).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 7).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // View based on Category Constriants
    private func categoryLogoAndDetailsConstraints() {
        categoryLogo.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5).isActive = true
        categoryLogo.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5).isActive = true
        categoryLogo.heightAnchor.constraint(equalToConstant: 28).isActive = true
        categoryLogo.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        categoryDetailsLabel.centerYAnchor.constraint(equalTo: categoryLogo.centerYAnchor).isActive = true
        categoryDetailsLabel.leadingAnchor.constraint(equalTo: categoryLogo.trailingAnchor, constant: 5).isActive = true
        categoryDetailsLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
    }
    
    // Details Label Constraints
    private func playButtonConstriants() {
        playButton.topAnchor.constraint(equalTo: categoryLogo.bottomAnchor, constant: 10).isActive = true
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
        castLabel.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5).isActive = true
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
            trailerTable.heightAnchor.constraint(equalToConstant: 260*3),
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
    
    private func layoutSwitchedViews() {
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
        categoryLogoAndDetailsConstraints()
        playButtonConstriants()
        overViewLabelConstriants()
        castLabelConstriants()
        directorLabelConstriants()
        threeButtonsConstriants()
        viewSwitchButtonsConstriants()
        layoutSwitchedViews()
    }
    
    
    //MARK: - Main Views Declaration
    private let entertainmentTrailer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
//    private let entertainmentTrailer: WKWebView = {
//        let webView = WKWebView()
//        webView.translatesAutoresizingMaskIntoConstraints = false
////        webView.layer.cornerRadius = 10
////        webView.clipsToBounds = true
//        return webView
//    }()
    
    
    
    private let containterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - Container SubViews Declaration
    private let netflixLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "netflixClone")
        imageView.image = image!.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "F I L M"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let entertainmentTitle: UILabel = {
        let label = UILabel()
        label.text = "Movie Title"
        label.textColor = .white
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "New 2024 1h 29m HD"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "top10")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "#1 in Movies Today"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Desperate to keep custody of his daughter, a mixed martial arts fighter abandons a big match and races across Berlin to attend her birthday party."
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        let fullText = "Cast: Arthur Curry, Orm Marius, David Kane" + " ... more"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        let lightFont = UIFont.systemFont(ofSize: 12, weight: .light)
        let boldFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        attributedString.addAttribute(.font, value: lightFont, range: NSRange(location: 0, length: fullText.count - 9))
        attributedString.addAttribute(.font, value: boldFont, range: NSRange(location: fullText.count - 9, length: 9))
        
        label.attributedText = attributedString
        label.textColor = .lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.text = "Director: James Wan"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var trailers: [Entertainment] = [Entertainment]()
    
}
