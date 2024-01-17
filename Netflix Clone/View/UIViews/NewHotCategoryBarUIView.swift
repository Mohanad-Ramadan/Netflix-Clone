//
//  NewHotCategoryBarUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 17/01/2024.
//

import UIKit

class NewHotCategoryBarUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(comingSoonButton)
        addSubview(everyoneWatchingButton)
        addSubview(toptenTvButton)
        addSubview(toptenMovieButton)
        applyConstraints()
        
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            comingSoonButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            comingSoonButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            comingSoonButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            
            // Button 2
            everyoneWatchingButton.leadingAnchor.constraint(equalTo: comingSoonButton.trailingAnchor, constant: 8),
            everyoneWatchingButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            everyoneWatchingButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            
            // Button 3
            toptenTvButton.leadingAnchor.constraint(equalTo: everyoneWatchingButton.trailingAnchor, constant: 8),
            toptenTvButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            toptenTvButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            
            toptenMovieButton.leadingAnchor.constraint(equalTo: everyoneWatchingButton.trailingAnchor, constant: 8),
            toptenMovieButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            toptenMovieButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
        ])
    }
    
    private func createButton(title: String, image: UIImage? = nil) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .capsule
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .bold)
            return outgoing
        }
        
        if let image = image {
            configuration.image = image
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 8
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var comingSoonButton: UIButton = createButton(title: "Coming Soon")
    private lazy var everyoneWatchingButton: UIButton = createButton(title: "Everyone's Watching")
    private lazy var toptenTvButton: UIButton = createButton(title: "Top 10 TV Shows")
    private lazy var toptenMovieButton: UIButton = createButton(title: "Top 10 Movies Shows")
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
