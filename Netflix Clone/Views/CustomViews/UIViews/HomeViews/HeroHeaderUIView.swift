//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import UIKit
import SDWebImage

class HeroHeaderUIView: UIView {
    // Delegate protocol
    protocol Delegate:AnyObject {func finishLoadingPoster(); func saveMediaToList(); func removeMediafromList()}
    
    //MARK: Declare Variables
    private let posterImageView: NFWebImageView = {
        let image = NFWebImageView(cornerRadius: 15, autoLayout: false)
        image.layer.borderWidth = 1
        image.layer.borderColor = CGColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.1)
        return image
    }()
    
    private let shadowWrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        return wrapperView
    }()
    
    private let genresLabel: NFBodyLabel = {
        let label = NFBodyLabel(fontSize: 14, fontWeight: .medium, textAlignment: .center)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()
    private let logoView = NFWebImageView(contentMode: .scaleAspectFit, autoLayout: false)
    private let playButton = NFFilledButton(title: "Play",image: UIImage(systemName: "play.fill"), fontSize: 18, fontWeight: .semibold)
    private let myListButton = NFFilledButton(title: "My List",image: UIImage(systemName: "plus"), fontSize: 18, fontWeight: .semibold)
        
    
    var media: Media?
    weak var delegate: Delegate?
    
    
    //MARK: - Load View
    override init(frame: CGRect) {
        super.init(frame: frame)
        [shadowWrapperView, logoView, genresLabel, playButton, myListButton].forEach {addSubview($0)}
        shadowWrapperView.addSubview(posterImageView)
        setupShadows()
        configureListButtonAction()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    
    //MARK: - Setup View
    func configureHeaderView(with images: ImageViewModel, genresDetail: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            if let backdropPath = images.backdropsPath, let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780/\(backdropPath)") {
                self.posterImageView.sd_setImage(with: backdropURL) { [weak self] (_, _, _, _) in
                    guard let self else {return}
                    self.getImageDominantColor()
                    self.delegate?.finishLoadingPoster()
                }
            }
            
            if let logoPath = images.logoPath , let logoURL = URL(string: "https://image.tmdb.org/t/p/w500/\(logoPath)") {
                self.logoView.sd_setImage(with: logoURL)
            }
            
            self.genresLabel.text = genresDetail
        }
    }
    
    // Setup ListButton
    private func configureListButtonAction() {
        myListButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        setupMyListButtonUI()
    }
    
    @objc private func listButtonTapped() {
        Task {
            guard let media else {return}
            let itemIsNew = PersistenceDataManager.shared.isItemNewToList(item: media)
            
            if itemIsNew {
                try await PersistenceDataManager.shared.addToMyListMedia(media)
                NotificationCenter.default.post(name: NSNotification.Name(NotificationKey.myListKey), object: nil)
                // change button Image
                myListButton.configuration?.image = UIImage(systemName: "checkmark")
                // notify delegate that button been tapped
                delegate?.saveMediaToList()
            } else {
                try await PersistenceDataManager.shared.deleteMediaFromList(media)
                NotificationCenter.default.post(name: NSNotification.Name(NotificationKey.myListKey), object: nil)
                // change button Image
                myListButton.configuration?.image = UIImage(systemName: "plus")
                // notify delegate that button been tapped
                delegate?.removeMediafromList()
            }
        }
    }
    
    func setupMyListButtonUI() {
        Task {
            guard let media else {return}
            let itemIsNew = PersistenceDataManager.shared.isItemNewToList(item: media)
            if itemIsNew {
                myListButton.configuration?.image = UIImage(systemName: "plus")
            } else {
                myListButton.configuration?.image = UIImage(systemName: "checkmark")
            }
        }
    }
    
    //MARK: - Setup View's Shadow
    private func setupShadows() {
        createShadowFor(shadowWrapperView, opacity: 0.3, radius: 8)
        createShadowFor(genresLabel, opacity: 0.4, radius: 2)
    }
    
    private func createShadowFor(_ view: UIView, opacity: Float, radius: CGFloat){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = radius
    }

    //MARK: - Constraints
    private func applyConstraints() {
        
        // Apply constraints shadowContainerView
        let shadowWrapperConstraints = [
            shadowWrapperView.topAnchor.constraint(equalTo: topAnchor),
            shadowWrapperView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shadowWrapperView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/1.7),
            shadowWrapperView.widthAnchor.constraint(equalTo: shadowWrapperView.heightAnchor, multiplier: 2.8/4)
        ]
        
        // Apply constraints for posterImageView inside shadowContainerView
        let imageConstraints = [
            posterImageView.topAnchor.constraint(equalTo: shadowWrapperView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: shadowWrapperView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: shadowWrapperView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: shadowWrapperView.bottomAnchor)
        ]
        
        // logoView constraints
        let logoViewConstraints = [
            logoView.bottomAnchor.constraint(equalTo: genresLabel.topAnchor, constant: -10),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.1),
            logoView.trailingAnchor.constraint(equalTo: myListButton.trailingAnchor, constant: -20),
            logoView.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 20)
        ]

        // Category constraints
        let categoryConstraints = [
            genresLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -20),
            genresLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: myListButton.trailingAnchor, constant: -10),
            genresLabel.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 10)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -7),
            playButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            playButton.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 15),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let listButtonConstraints = [
            myListButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 7),
            myListButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            myListButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -15),
            myListButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        [shadowWrapperConstraints, imageConstraints, logoViewConstraints, categoryConstraints, playButtonConstraints, listButtonConstraints
        ].forEach{NSLayoutConstraint.activate($0)}
    }
    
}


//MARK: - Setup Gradient
extension HeroHeaderUIView {
    // get the dominant color
    func getImageDominantColor(){
        guard let posterImage = posterImageView.image,
              let dominatColor = UIColor.dominantColor(from: posterImage) else{return}
        addGradientLayer(color: dominatColor)
    }
    
    // create Gradient layer
    private func addGradientLayer(color: UIColor) {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            color.withAlphaComponent(0.1).cgColor,
            color.withAlphaComponent(0.2).cgColor,
            color.withAlphaComponent(0.3).cgColor,
            color.withAlphaComponent(0.4).cgColor,
            color.withAlphaComponent(0.5).cgColor,
            color.withAlphaComponent(0.6).cgColor,
            color.withAlphaComponent(0.7).cgColor,
            color.withAlphaComponent(0.8).cgColor,
            color.withAlphaComponent(0.9).cgColor,
            color.cgColor
        ]
        let stepSize = 0.46 / Double(gradientLayer.colors?.count ?? 1)

        let locations = Array(stride(from: 0.43, through: 1.0, by: stepSize))
        gradientLayer.locations = locations.map { NSNumber(value: $0) }
        posterImageView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = posterImageView.bounds
    }
}
