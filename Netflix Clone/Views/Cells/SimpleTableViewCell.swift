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
        [entertainmentBackdropImageView, titleLabel, playTitleButton].forEach{addSubview($0)}
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
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playTitleButton.widthAnchor.constraint(equalTo: playTitleButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    private let entertainmentBackdropImageView = NFWebImageView(cornerRadius: 6, autoLayout: false)

    private let titleLabel = NFBodyLabel(fontSize: 15, fontWeight: .semibold, lines: 2)
    
    private let playTitleButton = NFSymbolButton(imageName: "play.circle", imageSize: 35)

    
    static let identifier = "SimpleTableViewCell"
    
    
    required init?(coder: NSCoder) {fatalError()}
}

