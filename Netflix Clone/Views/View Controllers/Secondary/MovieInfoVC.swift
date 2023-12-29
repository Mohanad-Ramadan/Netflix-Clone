//
//  MovieInfoViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/10/2023.
//

import UIKit
import WebKit

class MovieInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(webView)
        view.addSubview(titleLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(overViewLabel)
        view.addSubview(downloadButton)
        
        applyConstraints()
        
    }
    
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private func applyConstraints() {
        
        let webConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 350)
        ]
            
        let labelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let overViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -25),
            
            overViewLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            overViewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            overViewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            overViewLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -5)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(overViewConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }
    
    public func configureMovieInfo(with model: MovieInfoViewModel){
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else {
            fatalError("can't get the youtube trailer url")
        }
        
        webView.load(URLRequest(url: url))
    }
    
    
}
