//
//  MovieCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/10/2023.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configureCell(with endpoint: String){ posterImageView.downloadImageFrom(endpoint) }
    
    private let posterImageView = NFWebImageView(cornerRadius: 5)
    
    static let identifier = "PosterCollectionViewCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
