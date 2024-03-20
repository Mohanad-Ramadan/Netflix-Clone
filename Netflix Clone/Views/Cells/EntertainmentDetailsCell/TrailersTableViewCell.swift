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

    public func configureCell(with videoInfo: Trailer.Reuslts, and entertainmentName: String){
        let videoName = videoInfo.name
        let videoType = videoInfo.type
        let trailerQuery = "\(entertainmentName) \(videoName) \(videoType)"
        let trailerTitle = "\(videoType): \(videoName)"
        
        // Configure the trailer title
        self.trailerTitle.text = trailerTitle
        
        // Configure the trailer webView
        Task {
            do {
                let trailerId = try await NetworkManager.shared.getTrailersIds(of: trailerQuery)
                guard let url = URL(string: "https://www.youtube.com/embed/\(trailerId)") else {
                    fatalError("can't get the youtube trailer url")
                }
                self.trailerView.load(URLRequest(url: url))
            } catch { print(error.localizedDescription) }
        }
        
    }
    
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            // TrailerView Constraints
            trailerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trailerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trailerView.heightAnchor.constraint(equalToConstant: 230),
            trailerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10),
            
            // TrailerTitle Constraints
            trailerTitle.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 10),
            trailerTitle.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor)
            
        ])
    }
    
    private let trailerView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.layer.cornerRadius = 5
        webView.clipsToBounds = true
        webView.scrollView.isScrollEnabled = false
        return webView
    }()
    
    private let trailerTitle = NFBodyLabel(fontSize: 14, fontWeight: .semibold)

    
    required init?(coder: NSCoder) {fatalError()}
}
