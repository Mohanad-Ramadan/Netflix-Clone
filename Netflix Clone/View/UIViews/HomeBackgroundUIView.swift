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
    
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    //MARK: - Get Poster dominant color
    func getImageDominantColor() {
        guard let backImage = backGroundPoster.image else{return}
        
        let dominatColor = UIColor.dominantColor(from: backImage)
        addGradientLayer(color: dominatColor!)
    }
    
    //MARK: - Gradient layer
    private func addGradientLayer(color: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            color.cgColor,
            UIColor.black.cgColor
        ]
        
        gradientLayer.locations = [NSNumber(value: 0.4), NSNumber(value: 0.8) ]
        
        backGroundPoster.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        gradientLayer.frame = backGroundPoster.bounds
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
    
    private var backGroundPoster : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

