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
        contentView.addSubview(youtubePlayerVC.view)
        contentView.addSubview(trailerTitle)
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
            
            // TrailerView Constraints
            youtubePlayerVC.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            youtubePlayerVC.view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            youtubePlayerVC.view.heightAnchor.constraint(equalToConstant: 230),
            youtubePlayerVC.view.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10),
            
            // TrailerTitle Constraints
            trailerTitle.topAnchor.constraint(equalTo: youtubePlayerVC.view.bottomAnchor, constant: 10),
            trailerTitle.leadingAnchor.constraint(equalTo: youtubePlayerVC.view.leadingAnchor)
            
        ])
    }
    
    private lazy var youtubePlayerVC: YouTubePlayerViewController = {
        lazy var youtubePlayer = YouTubePlayer(configuration: .init(fullscreenMode: .system,openURLAction: .init(handler: { _ in }),showCaptions: true,showFullscreenButton: false))
        let youtubeVC = YouTubePlayerViewController(player: youtubePlayer)
        youtubeVC.view.translatesAutoresizingMaskIntoConstraints = false
        return youtubeVC
    }()
    
    private let trailerTitle = NFBodyLabel(fontSize: 14, fontWeight: .semibold)

    
    required init?(coder: NSCoder) {fatalError()}
}
