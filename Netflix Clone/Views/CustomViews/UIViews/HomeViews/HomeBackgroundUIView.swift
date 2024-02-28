//
//  HomeBackgroundView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 22/11/2023.
//

import UIKit

class HomeBackgroundUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backGroundPoster)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundPoster.frame = bounds
    }
    
    //MARK: - Configure Poster Image
    func configureBackground(with model: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let backdropPath = model.backdropsPath, let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)") {
                self?.backGroundPoster.sd_setImage(with: backdropURL) { [weak self] (_, _, _, _) in
                    self?.getImageDominantColor()
                }
            }
        }
    }
    
    //MARK: - Get Poster dominant color
    func getImageDominantColor() {
        guard let backImage = backGroundPoster.image else{return}
        
        let dominantColor = UIColor.dominantColor(from: backImage)
        addGradientLayer(color: dominantColor!)
    }
    
    //MARK: - Gradient layer
    func addGradientLayer(color: UIColor) {
        gradientLayer.colors = [
            color.cgColor,
            UIColor.black.cgColor
        ]

        gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 1.0)]
        backGroundPoster.layer.addSublayer(gradientLayer)
        gradientLayer.frame = backGroundPoster.bounds
    }
    
    // Change location by scrolling
    func changeGradientLocations(to currentlocation: CGFloat){
        DispatchQueue.main.async {
            self.gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: currentlocation)]
        }
    }
    
    //MARK: - Declare UIElements
    private var backGroundPoster = NFPosterImageView(autoLayout: false)
    
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

