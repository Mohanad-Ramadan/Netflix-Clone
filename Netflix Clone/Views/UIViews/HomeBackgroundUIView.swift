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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Get Poster dominant color
    func getImageDominantColor() {
        do{
            let imageColor = try backGroundPoster.image?.averageColor() ?? .black
//            addGradientLayer(color: imageColor)
            backgroundColor = imageColor.darken(by: 0.2)
        }catch {
            return
        }
    }
    
    //MARK: - Configure Poster Image
    func configureHeaderPoster(with model: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let posterPath = model.posterPath, let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                self?.backGroundPoster.sd_setImage(with: posterURL) { [weak self] (_, _, _, _) in
                    self?.getImageDominantColor()
                }
            }
        }
    }
    
    private let backGroundPoster = UIImageView()
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


