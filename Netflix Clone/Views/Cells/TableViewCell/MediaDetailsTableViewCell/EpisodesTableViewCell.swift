//
//  EpisodesTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 24/03/2024.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        [episodeImageView, playEpisodeButton, titleLabel, runtime, overview].forEach{contentView.addSubview($0)}
        applyConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeImageView.image = nil
        titleLabel.text = nil
        runtime.text = nil
        overview.text = nil
    }
    
    
    func configureCellDetail(from episode: SeasonDetail.Episode){
        episodeImageView.downloadImageFrom(episode.stillPath ?? "noPath")
        titleLabel.text = "\(episode.episodeNumber ?? 0). \(episode.name ?? "")"
        runtime.text = episode.runtime?.formatTimeFromMinutes()
        overview.text = episode.overview
    }
    
    
    private func applyConstraints() {
        let episodeImageViewConstraints = [
            episodeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            episodeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            episodeImageView.heightAnchor.constraint(equalToConstant: 85),
            episodeImageView.widthAnchor.constraint(equalToConstant: 150),
            episodeImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5),
            episodeImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ]
        
        let playButtonConstraints = [
            playEpisodeButton.centerXAnchor.constraint(equalTo: episodeImageView.centerXAnchor),
            playEpisodeButton.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
        ]
        
        let runtimeConstraints = [
            runtime.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            runtime.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ]
        
        let overviewConstraints = [
            overview.leadingAnchor.constraint(equalTo: episodeImageView.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            overview.topAnchor.constraint(equalTo: episodeImageView.bottomAnchor, constant: 10),
            overview.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(episodeImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(runtimeConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    let episodeImageView = NFWebImageView(cornerRadius: 6, autoLayout: false)

    let titleLabel = NFBodyLabel(fontSize: 14)
    
    let runtime = NFBodyLabel(text: "45",color: .lightGray, fontSize: 11, fontWeight: .light)
    
    let overview = NFBodyLabel(text: "Didn't find any.", color: .lightGray, fontSize: 15, lines: 0)

    let playEpisodeButton = NFSymbolButton(imageName: "play.circle", imageSize: 45)
    
    static let identifier = "EpisodesTableViewCell"
    
    
    required init?(coder: NSCoder) {fatalError()}

}
