//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit
import SDWebImage
import ColorKit

class HeroHeaderUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shadowWrapperView.addSubview(showImageView)
        [shadowWrapperView, logoView, categoryLabel, playButton, listButton].forEach { addSubview($0)
        }
        applyConstraints()
    }
    
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    private let showImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.layer.borderWidth = 1
        image.layer.borderColor = CGColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.4)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    private let shadowWrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.layer.shadowColor = UIColor.black.cgColor
        wrapperView.layer.shadowOpacity = 0.3
        wrapperView.layer.shadowOffset = CGSize.zero
        wrapperView.layer.shadowRadius = 8
        return wrapperView
    }()
    
    private let logoView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowRadius = 2
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
            outgoing.font = UIFont.boldSystemFont(ofSize: 18)
            return outgoing
        }
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 1
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let listButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "My List"
        configuration.baseBackgroundColor = .systemGray5
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "plus")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.cornerStyle = .small
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.boldSystemFont(ofSize: 18)
            return outgoing
        }
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 1
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Get Poster dominant color
    func getImageDominantColor(){
        do{
            let imageColor = try showImageView.image?.averageColor() ?? .black
            addGradientLayer(color: imageColor.darken(by: 0.1))
        }catch {
            return
        }
    }
    
    //MARK: - Gradient layer
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
        
        showImageView.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        gradientLayer.frame = showImageView.bounds
    }
    
    //MARK: - Configure Poster Image
    func configureHeaderView(with model: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let backdropPath = model.backdropsPath, let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780/\(backdropPath)") {
                self?.showImageView.sd_setImage(with: backdropURL) { [weak self] (_, _, _, _) in
                    self?.getImageDominantColor()
                }
            }
            if let logoPath = model.logoPath , let logoURL = URL(string: "https://image.tmdb.org/t/p/w500/\(logoPath)") {
                self?.logoView.sd_setImage(with: logoURL)
            }
            self?.categoryLabel.text = model.category
        }
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let shadowWrapperConstraints = [
            shadowWrapperView.topAnchor.constraint(equalTo: topAnchor),
            shadowWrapperView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shadowWrapperView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/1.7),
            shadowWrapperView.widthAnchor.constraint(equalTo: shadowWrapperView.heightAnchor, multiplier: 2.8/4)
        ]
        
        


        // Apply constraints for posterImageView inside shadowContainerView
        let imageConstraints = [
            showImageView.topAnchor.constraint(equalTo: shadowWrapperView.topAnchor),
            showImageView.leadingAnchor.constraint(equalTo: shadowWrapperView.leadingAnchor),
            showImageView.trailingAnchor.constraint(equalTo: shadowWrapperView.trailingAnchor),
            showImageView.bottomAnchor.constraint(equalTo: shadowWrapperView.bottomAnchor)
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
            playButton.bottomAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: -20),
            playButton.leadingAnchor.constraint(equalTo: showImageView.leadingAnchor, constant: 15),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let listButtonConstraints = [
            listButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 7),
            listButton.bottomAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: -20),
            listButton.trailingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: -15),
            listButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(shadowWrapperConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(logoViewConstraints)
        NSLayoutConstraint.activate(categoryConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(listButtonConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


