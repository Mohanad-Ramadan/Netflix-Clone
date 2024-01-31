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
        let videoQuery = "\(entertainmentName) \(videoName) \(videoType)"
        let trailerTitle = "\(videoType): \(videoName)"
        
        // Configure the trailer title
        self.trailerTitle.text = trailerTitle
        
        // Configure the trailer webView
        APICaller.shared.getYoutubeVideos(query: videoQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let videoId):
                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else {
                        fatalError("can't get the youtube trailer url")
                    }
                    self.trailerView.load(URLRequest(url: url))
                case .failure(let failure):
                    print("Error getting Trailer video:", failure)
                }
            }
        }
        
    }
    
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            // TrailerView Constraints
            trailerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trailerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trailerView.heightAnchor.constraint(equalToConstant: 230),
            trailerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            // TrailerTitle Constraints
            trailerTitle.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 10),
            trailerTitle.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor, constant: 5)
            
        ])
    }
    
    private let trailerView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.layer.cornerRadius = 8
        return webView
    }()
    
    private let trailerTitle: UILabel = {
        let label = UILabel()
        label.text = "Teaser: Sixty wings"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    required init?(coder: NSCoder) {fatalError()}

}
