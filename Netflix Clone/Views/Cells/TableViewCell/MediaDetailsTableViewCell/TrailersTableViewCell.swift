//
//  TrailersTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/01/2024.
//

import UIKit
import WebKit
import YouTubePlayerKit

class TrailersTableViewCell: UITableViewCell {
    
    static let identifier = "TrailersTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        configureContentView()
    }
    
    
    private func configureContentView() {
        contentView.addSubview(stackViewContainer)
        [youtubePlayerVC.view, separatorLine, trailerTitle].forEach{stackViewContainer.addArrangedSubview($0)}
        applyConstraints()
    }

    
    public func configureCell(with videoInfo: Trailer.Reuslts, and mediaName: String){
        // Configure the trailer title
        self.trailerTitle.text = "\(videoInfo.type): \(videoInfo.name)"
        
        // Configure the trailer webView
        Task {
            do { try await self.youtubePlayerVC.player.load(source: .video(id: videoInfo.key)) }
            catch { print(error.localizedDescription) }
        }
        
    }
    
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // TrailerView Constraints
            youtubePlayerVC.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            youtubePlayerVC.view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            youtubePlayerVC.view.heightAnchor.constraint(equalToConstant: 230),
            youtubePlayerVC.view.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            // separator
            separatorLine.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor, constant: 10),
            separatorLine.widthAnchor.constraint(equalToConstant: 50),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            // TrailerTitle Constraints
            trailerTitle.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor, constant: 9)
        ])
        stackViewContainer.setCustomSpacing(-4, after: separatorLine)
    }
    
    //MARK: - Declare Varaibles
    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.backgroundColor = .fadedBlack
        stackView.layer.cornerRadius = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var youtubePlayerVC: YouTubePlayerViewController = {
        lazy var youtubePlayer = YouTubePlayer(
            configuration: .init(
                fullscreenMode: .system,
                openURLAction: .init(handler: { _ in }),
                autoPlay: false ,
                showCaptions: true,
                showControls: false,
                showFullscreenButton: false
            )
        )
        let youtubeVC = YouTubePlayerViewController(player: youtubePlayer)
        return youtubeVC
    }()

    private let separatorLine: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        return rectangle
    }()
    
    private let trailerTitle = NFBodyLabel(fontSize: 15, fontWeight: .semibold, autoLayout: true)
    
    required init?(coder: NSCoder) {fatalError()}
}
