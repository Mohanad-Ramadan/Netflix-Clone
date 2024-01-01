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
        
        [posterImageView, playButton, listButton].forEach { addSubview($0)
        }
        
        addGradient()
        applyConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePosterFrame()
    }
    
    
    public func configureHeaderPoster(with model: MovieViewModel){
        DispatchQueue.main.async { [weak self] in
            if let posterPath = model.posterPath ,let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"){
                self?.posterImageView.sd_setImage(with: posterURL) {[weak self] _,_,_,_ in
                    self?.updatePosterFrame()
                }
            }
        }
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.9).cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [NSNumber(value: 0.4), NSNumber(value: 0.8), NSNumber(value: 1.0)]
        gradientLayer.frame = bounds
        posterImageView.layer.addSublayer(gradientLayer)
    }
    
    private let posterImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 9
        image.layer.borderWidth = 1
        image.layer.borderColor = CGColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.4)
        image.clipsToBounds = true
        //        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    //MARK: - Frame and Constraints
    
    private func updatePosterFrame() {
        if let image = posterImageView.image {
            let aspectRatio = image.size.width / image.size.height
            let targetWidth = bounds.width/1.1
            let targetHeight = targetWidth / aspectRatio
            
            posterImageView.frame = CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight)
            posterImageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    private func applyConstraints() {
        
        //        let posterViewConstraints = [
        //            posterImageView.topAnchor.constraint(equalTo: topAnchor),
        //            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        //            posterImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2.5),
        //            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2.8/4)
        //        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -7),
            playButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let listButtonConstraints = [
            listButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 7),
            listButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            listButton.widthAnchor.constraint(equalToConstant: 150),
            listButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        //        NSLayoutConstraint.activate(posterViewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(listButtonConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


