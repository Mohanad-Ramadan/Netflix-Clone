//
//  SimpleTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/01/2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [mediaBackdropImageView, titleLabel, playTitleButton].forEach{contentView.addSubview($0)}
        applyConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mediaBackdropImageView.image = nil
    }
    
    func configure(with media: Media){
        Task {
            do {
                let mediaType = media.mediaType ?? "movie"
                let id = media.id
                let title = media.title ?? media.originalName
                
                let images = try await NetworkManager.shared.getImagesFor(mediaId: id ,ofType: mediaType)
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                configureCell(with: MediaViewModel(title: title ,backdropsPath: backdropPath))
            } catch {
                print("Error getting images:", error.localizedDescription)
            }
        }
    }
    
    func configureCell(with model: MediaViewModel){
        mediaBackdropImageView.downloadImageFrom(model.backdropsPath ?? "noPath")
        titleLabel.text = model.title
    }
    
    
    private func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            mediaBackdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mediaBackdropImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mediaBackdropImageView.heightAnchor.constraint(equalToConstant: 85),
            mediaBackdropImageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: mediaBackdropImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            playTitleButton.widthAnchor.constraint(equalToConstant: 40),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    private let mediaBackdropImageView = NFWebImageView(cornerRadius: 6, autoLayout: false)

    private let titleLabel = NFBodyLabel(fontSize: 15, fontWeight: .semibold, lines: 0)
    
    private let playTitleButton = NFSymbolButton(imageName: "play.circle", imageSize: 35)

    
    static let identifier = "SimpleTableViewCell"
    
    
    required init?(coder: NSCoder) {fatalError()}
}

