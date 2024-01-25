//
//  SimpleTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/01/2024.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    static let identifier = "SimpleTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(entertainmentBackdropImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            entertainmentBackdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            entertainmentBackdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            entertainmentBackdropImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            entertainmentBackdropImageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: entertainmentBackdropImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let entertainmentBackdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    public func configureTitlePoster(with model: MovieViewModel){
        if let backdropPath = model.backdropsPath ,let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)"){
            entertainmentBackdropImageView.sd_setImage(with: backdropURL)
        }
        titleLabel.text = model.title
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

