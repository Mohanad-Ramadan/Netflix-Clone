//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit
import SDWebImage

class HeroHeaderUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [shadowWrapperView, logoView, categoryLabel, playButton, listButton].forEach {addSubview($0)}
        shadowWrapperView.addSubview(posterImageView)
        configureViews()
    }
    
    //MARK: - Configure Poster Image
    func configureHeaderView(with model: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let backdropPath = model.backdropsPath, let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780/\(backdropPath)") {
                self?.posterImageView.sd_setImage(with: backdropURL) { [weak self] (_, _, _, _) in
                    self?.getImageDominantColor()
                }
            }
            
            if let logoPath = model.logoPath , let logoURL = URL(string: "https://image.tmdb.org/t/p/w500/\(logoPath)") {
                self?.logoView.sd_setImage(with: logoURL)
            }
            
            self?.categoryLabel.text = model.category
        }
    }
    
    //MARK: - Get Poster dominant color
    func getImageDominantColor(){
        guard let posterImage = posterImageView.image else{return}
        
        let dominatColor = UIColor.dominantColor(from: posterImage)
        addGradientLayer(color: dominatColor!)
    }
    
    //MARK: - Create Gradient layer
    private func addGradientLayer(color: UIColor) {
        let gradientLayer = CAGradientLayer()
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
    
    //MARK: - Shadow method for views
    private func createShadowFor(_ view: UIView, opacity: Float, radius: CGFloat){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = radius
    }

    //MARK: - Configure Views
    private func configureViews() {
        // Apply shadow for some views
        createShadowFor(shadowWrapperView, opacity: 0.3, radius: 8)
        [categoryLabel, playButton, listButton].forEach {createShadowFor($0, opacity: 0.4, radius: 2)}
        
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
            logoView.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -10),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.1),
            logoView.trailingAnchor.constraint(equalTo: listButton.trailingAnchor, constant: -20),
            logoView.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 20)
        ]

        // Category constraints
        let categoryConstraints = [
            categoryLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -20),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: listButton.trailingAnchor, constant: -10),
            categoryLabel.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 10)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -7),
            playButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            playButton.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 15),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let listButtonConstraints = [
            listButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 7),
            listButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            listButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -15),
            listButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        [shadowWrapperConstraints, imageConstraints, logoViewConstraints, categoryConstraints, playButtonConstraints, listButtonConstraints
        ].forEach{NSLayoutConstraint.activate($0)}
    }
    
    
    //MARK: - Declare Subviews
    private let posterImageView: NFPosterImageView = {
        let image = NFPosterImageView(cornerRadius: 15, autoLayout: false)
        image.layer.borderWidth = 1
        image.layer.borderColor = CGColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.1)
        return image
    }()
    
    private let shadowWrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        return wrapperView
    }()
    
    private let logoView = NFPosterImageView(contentMode: .scaleAspectFit, autoLayout: false)
    
    private let categoryLabel: NFBodyLabel = {
        let label = NFBodyLabel(fontSize: 14, fontWeight: .medium, textAlignment: .center)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let playButton = NFFilledButton(title: "Play",image: UIImage(systemName: "play.fill"), fontSize: 18, fontWeight: .bold)
    
    private let listButton = NFFilledButton(title: "My List",image: UIImage(systemName: "plus"), fontSize: 18, fontWeight: .bold)
    
    
    required init?(coder: NSCoder) {fatalError()}
}


