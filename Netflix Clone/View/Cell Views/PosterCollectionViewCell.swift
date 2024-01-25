//
//  MovieCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/10/2023.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    //MARK: - Edite here
    
    public func configureTitle(with model: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)" ) else {return}
        posterImageView.sd_setImage(with: url)
    }
    
}
