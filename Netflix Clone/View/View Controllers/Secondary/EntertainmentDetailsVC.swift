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
            tableSwitchButtons,
            
        ].forEach {containterScrollView.addSubview($0)}

        tableSwitchButtons.buttonsTarget()
        applyConstraints()
    }
    
    //MARK: - Backend Methods
//    public func configureMovieInfo(with model: MovieInfoViewModel){
//        titleLabel.text = model.title
//        overViewLabel.text = model.titleOverview
//
//        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else {
//            fatalError("can't get the youtube trailer url")
//        }
//
//        webView.load(URLRequest(url: url))
//    }
    
    //MARK: - Main Views constraints
    
    // Trailer Video
    private func trailerVideoConstraints() {
        entertainmentTrailer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3).isActive = true
        entertainmentTrailer.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        entertainmentTrailer.heightAnchor.constraint(equalToConstant: 350).isActive = true
        entertainmentTrailer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3).isActive = true
    }
    
    // ScrollView Constraints
    private func scrollViewConstriants() {
        containterScrollView.topAnchor.constraint(equalTo: entertainmentTrailer.bottomAnchor, constant: 10).isActive = true
        containterScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        containterScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        containterScrollView.heightAnchor.constraint(equalTo: containterScrollView.heightAnchor).isActive = true
    }
    
    //MARK: -  SubViews constraints
    
    // Netflixlogo + CategoryLabel Constraints
    private func neflixlogoAndGenresLabelConstriants() {
        netflixLogo.topAnchor.constraint(equalTo: containterScrollView.topAnchor).isActive = true
        netflixLogo.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        netflixLogo.heightAnchor.constraint(equalTo: netflixLogo.heightAnchor).isActive = true
        netflixLogo.widthAnchor.constraint(equalTo: netflixLogo.widthAnchor).isActive = true
        
        categoryLabel.centerYAnchor.constraint(equalTo: netflixLogo.centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: netflixLogo.trailingAnchor, constant: 10).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
    }
    
    // Title Constraints
    private func entertainmentTitleConstriants() {
        entertainmentTitle.topAnchor.constraint(equalTo: netflixLogo.bottomAnchor, constant: 5).isActive = true
        entertainmentTitle.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        entertainmentTitle.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
    }
    
    // Details Label Constraints
    private func detailsLabelConstriants() {
        detailsLabel.topAnchor.constraint(equalTo: entertainmentTitle.bottomAnchor, constant: 15).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
    }
    
    // View based on Category Constriants
    private func categoryLogoAndDetailsConstraints() {
        categoryLogo.topAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: 10).isActive = true
        categoryLogo.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        categoryLogo.heightAnchor.constraint(equalTo: categoryLogo.heightAnchor).isActive = true
        categoryLogo.widthAnchor.constraint(equalTo: categoryLogo.widthAnchor).isActive = true
        
        categoryDetailsLabel.centerYAnchor.constraint(equalTo: categoryLogo.centerYAnchor).isActive = true
        categoryDetailsLabel.leadingAnchor.constraint(equalTo: categoryLogo.trailingAnchor, constant: 10).isActive = true
        categoryDetailsLabel.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
    }
    
    // Details Label Constraints
    private func playButtonConstriants() {
        playButton.topAnchor.constraint(equalTo: categoryLogo.bottomAnchor, constant: 10).isActive = true
        playButton.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        playButton.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
    }
    
    // OverView Label Constraints
    private func overViewLabelConstriants() {
        overViewLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 25).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor, constant: 10).isActive = true
    }
    
    // Cast Label Constraints
    private func castLabelConstriants() {
        castLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 20).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        castLabel.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor, constant: 15).isActive = true
    }
    
    // Director Label Constriatns
    private func directorLabelConstriants() {
        directorLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 5).isActive = true
        directorLabel.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        directorLabel.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor, constant: 15).isActive = true
    }
    
    // Three Buttons Constraints
    private func threeButtonsConstriants() {
        threeButtons.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 25).isActive = true
        threeButtons.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        threeButtons.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
    }
    
    // Table Switch Buttons Constraints
    private func tableSwitchButtonsConstriants() {
        tableSwitchButtons.topAnchor.constraint(equalTo: threeButtons.bottomAnchor, constant: 20).isActive = true
        tableSwitchButtons.leadingAnchor.constraint(equalTo: containterScrollView.leadingAnchor).isActive = true
        tableSwitchButtons.trailingAnchor.constraint(equalTo: containterScrollView.trailingAnchor).isActive = true
        tableSwitchButtons.heightAnchor.constraint(equalTo: tableSwitchButtons.heightAnchor).isActive = true
    }
    
    // Apply constriants function
    private func applyConstraints() {
        trailerVideoConstraints()
        scrollViewConstriants()
        neflixlogoAndGenresLabelConstriants()
        entertainmentTitleConstriants()
        detailsLabelConstriants()
        neflixlogoAndGenresLabelConstriants()
        categoryLogoAndDetailsConstraints()
        playButtonConstriants()
        overViewLabelConstriants()
        castLabelConstriants()
        directorLabelConstriants()
        threeButtonsConstriants()
        tableSwitchButtonsConstriants()
    }
    
    
    //MARK: - Main Views Declaration
    private let entertainmentTrailer: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "TestImage.heic"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = true
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
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - Container SubViews Declaration
    private let netflixLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "netflixClone")
        imageView.image = image!.sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFit)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "F I L M"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let entertainmentTitle: UILabel = {
        let label = UILabel()
        label.text = "Movie Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "New 2024 1h 29m HD"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let categoryLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "top10")
        imageView.image = image!.sd_resizedImage(with: CGSize(width: 50, height: 50), scaleMode: .aspectFit)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "#1 in Movies Today"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.textAlignment = .left
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
            outgoing.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Black Manta, still driven by the need to avenge his father's death and wielding the power of the mythic Black Trident, will stop at nothing to take Aquaman down once and for all. To defeat him, Aquaman must turn to his imprisoned brother Orm, the former King of Atlantis, to forge an unlikely alliance in order to save the world from irreversible destruction."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        let fullText = "Cast: Arthur Curry, Orm Marius, David Kane" + " ... more"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        let lightFont = UIFont.systemFont(ofSize: 18, weight: .light)
        let boldFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        attributedString.addAttribute(.font, value: lightFont, range: NSRange(location: 0, length: fullText.count - 9))
        attributedString.addAttribute(.font, value: boldFont, range: NSRange(location: fullText.count - 9, length: 9))
        
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.text = "Director: James Wan"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    private let threeButtons = ThreeButtonUIView()
    
    private let tableSwitchButtons = TableViewSwitchButtonsUIView()
    
}


