//
//  SimpleTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/01/2024.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(entertainmentBackdropImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    func configureCell(with model: MovieViewModel){
        entertainmentBackdropImageView.downloadImageFrom(model.backdropsPath ?? "noPath")
        titleLabel.text = model.title
    }
    
    
    private func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            entertainmentBackdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            entertainmentBackdropImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            entertainmentBackdropImageView.heightAnchor.constraint(equalToConstant: 85),
            entertainmentBackdropImageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: entertainmentBackdropImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: -20),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    private let entertainmentBackdropImageView = NFPosterImageView(cornerRadius: 6, autoLayout: false)
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel = NFBodyLabel(fontSize: 15, fontWeight: .semibold, lines: 2)
    
    static let identifier = "SimpleTableViewCell"
    
    
    required init?(coder: NSCoder) {fatalError()}
}

