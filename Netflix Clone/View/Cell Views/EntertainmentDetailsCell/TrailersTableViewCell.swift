//
//  TrailersTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/01/2024.
//

import UIKit
import WebKit

class TrailersTableViewCell: UITableViewCell {
    
    static let identifier = "TrailersTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(trailerView)
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
            trailerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trailerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trailerView.heightAnchor.constraint(equalToConstant: 300),
            trailerView.widthAnchor.constraint(equalToConstant: contentView.bounds.width-10),
            
            // TrailerTitle Constraints
            trailerTitle.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 5),
            trailerTitle.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor)
            
        ])
    }
    
//    private let trailerView: WKWebView = {
//        let webView = WKWebView()
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        return webView
//    }()
    
    private let trailerView: UIImageView = {
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
    
    
    required init?(coder: NSCoder) {fatalError()}
    
    
//    func configureTrailer(with model: MovieInfoViewModel){
//        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else {
//            fatalError("can't get the youtube trailer url")
//        }
//        
//        trailerView.load(URLRequest(url: url))
//        trailerTitle.text = model.title
//    }

}
