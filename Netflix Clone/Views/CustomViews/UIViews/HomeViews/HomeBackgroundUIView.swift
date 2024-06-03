//
//  HomeBackgroundView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 7/3/2024.
//

import UIKit

class HomeBackgroundUIView: UIView {
    
    private var backGroundPoster = NFWebImageView(autoLayout: false)
    
    //MARK: - Load View
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        backGroundPoster.alpha = 0
        addSubview(backGroundPoster)
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundPoster.frame = bounds
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    
    //MARK: - Setup View
    func configureBackground(with images: ImageViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let backdropPath = images.backdropsPath, let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)") {
                self?.backGroundPoster.sd_setImage(with: backdropURL) { [weak self] (_, _, _, _) in
                    self?.getImageDominantColor()
                }
            }
        }
    }
    
    
    //MARK: - Setup Gradient
    
    // Get Poster dominant color
    func getImageDominantColor() {
        guard let backImage = backGroundPoster.image,
              let dominantColor = UIColor.dominantColor(from: backImage) else{return}
        addGradientLayer(color: dominantColor)
    }
    
    // Gradient layer
    func addGradientLayer(color: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 2.2)]
        self.layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
    }
}

