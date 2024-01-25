//
//  TrailersTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/01/2024.
//

import UIKit

class TrailersTableViewCell: UITableViewCell {
    
    static let identifier = "TrailersTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(trailerImageView)
        contentView.addSubview(trailerTitle)
        
        applyConstraints()
    }
    
//    public func configureTitlePoster(with model: MovieViewModel){
//        if let posterPath = model.posterPath ,let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"){
//            posterImageView.sd_setImage(with: posterURL)
//        }
//        titleLabel.text = model.title
//    }
    
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            // TrailerView Constraints
            trailerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 5),
            trailerImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: -5),
            trailerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trailerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            trailerImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width-10),
            
            // TrailerTitle Constraints
            trailerTitle.leadingAnchor.constraint(equalTo: trailerImageView.trailingAnchor, constant: 20),
            trailerTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    
    private let trailerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testImageLarge")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trailerTitle: UILabel = {
        let label = UILabel()
        label.text = "Teaser: Sixty wings"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
