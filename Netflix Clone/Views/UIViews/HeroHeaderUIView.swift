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
        shadowContainerView.addSubview(posterImageView)
        shadowWrapperView.addSubview(shadowContainerView)
        [shadowWrapperView, logoView, categoryLabel, playButton, listButton].forEach { addSubview($0)
        }
        applyConstraints()
    }
    
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.layer.borderWidth = 1
        image.layer.borderColor = CGColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.4)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    // Container view for shadow
    private let shadowContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 15  // Add corner radius to match the posterImageView
        return containerView
    }()
    
    private let shadowWrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.layer.shadowColor = UIColor.black.cgColor
        wrapperView.layer.shadowOpacity = 0.5
        wrapperView.layer.shadowOffset = CGSize.zero
        wrapperView.layer.shadowRadius = 10
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
        label.text = "Violent.Suspental.Action"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowRadius = 0.5
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
            let imageColor = try posterImageView.image?.averageColor() ?? .black
            addGradientLayer(color: imageColor.darken(by: 0.2))
        }catch {
            return
        }
    }
    
    //MARK: - Gradient layer
    private func addGradientLayer(color: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            color.withAlphaComponent(0.6).cgColor,
            color.withAlphaComponent(0.8).cgColor,
            color.cgColor
        ]
        gradientLayer.locations = [NSNumber(value: 0.5), NSNumber(value: 0.7), NSNumber(value: 0.8), NSNumber(value: 1.0)]
        posterImageView.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        gradientLayer.frame = posterImageView.bounds
    }
    
    //MARK: - Configure Poster Image
    func configureHeaderPoster(with model: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let posterPath = model.posterPath, let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                self?.posterImageView.sd_setImage(with: posterURL) { [weak self] (_, _, _, _) in
                    self?.getImageDominantColor()
                }
            }
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
        
        // Apply constraints for shadowContainerView inside shadowWrapperView
        let shadowContainerConstraints = [
            shadowContainerView.topAnchor.constraint(equalTo: shadowWrapperView.topAnchor),
            shadowContainerView.leadingAnchor.constraint(equalTo: shadowWrapperView.leadingAnchor),
            shadowContainerView.trailingAnchor.constraint(equalTo: shadowWrapperView.trailingAnchor),
            shadowContainerView.bottomAnchor.constraint(equalTo: shadowWrapperView.bottomAnchor)
        ]


        // Apply constraints for posterImageView inside shadowContainerView
        let imageConstraints = [
            posterImageView.topAnchor.constraint(equalTo: shadowContainerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: shadowContainerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: shadowContainerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: shadowContainerView.bottomAnchor)
        ]
        
        // logoView constraints
        let logoViewConstraints = [
            logoView.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -5),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.trailingAnchor.constraint(equalTo: listButton.trailingAnchor, constant: -5),
            logoView.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 5)
        ]

        // Category constraints
        let categoryConstraints = [
            categoryLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -20),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: listButton.trailingAnchor, constant: -5),
            categoryLabel.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 5)
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
        NSLayoutConstraint.activate(shadowWrapperConstraints)
        NSLayoutConstraint.activate(shadowContainerConstraints)
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


