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
        addSubview(scrollView)
        scrollView.addSubview(comingSoonButton)
        scrollView.addSubview(everyoneWatchingButton)
        scrollView.addSubview(toptenTvButton)
        scrollView.addSubview(toptenMovieButton)
        applyConstraints()
        
        comingSoonButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        everyoneWatchingButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        toptenTvButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        toptenMovieButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)

        
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        handleUI(sender)
    }
    
    private func handleUI(_ sender: UIButton) {
        for button in buttons {
            button.configuration?.baseBackgroundColor = (button == sender) ? .white : .black
            button.configuration?.baseForegroundColor = (button == sender) ? .black : .white
        }
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView Containter
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            scrollView.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),

            // Button 1
            comingSoonButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            comingSoonButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            comingSoonButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),

            // Button 2
            everyoneWatchingButton.leadingAnchor.constraint(equalTo: comingSoonButton.trailingAnchor, constant: 10),
            everyoneWatchingButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            everyoneWatchingButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),

            // Button 3
            toptenTvButton.leadingAnchor.constraint(equalTo: everyoneWatchingButton.trailingAnchor, constant: 10),
            toptenTvButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            toptenTvButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),

            // Button 4
            toptenMovieButton.leadingAnchor.constraint(equalTo: toptenTvButton.trailingAnchor, constant: 10),
            toptenMovieButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            toptenMovieButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            toptenMovieButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
    
    
    private func createButton(title: String, image: UIImage?) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .bold)
            return outgoing
        }
        
        configuration.image = image!.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var comingSoonButton: UIButton = createButton(title: "Coming Soon", image: UIImage(named: "popcorn"))
    private lazy var everyoneWatchingButton: UIButton = createButton(title: "Everyone's Watching", image: UIImage(named: "fire"))
    private lazy var toptenTvButton: UIButton = createButton(title: "Top 10 TV Shows", image: UIImage(named: "top10"))
    private lazy var toptenMovieButton: UIButton = createButton(title: "Top 10 Movies", image: UIImage(named: "top10"))
    
    private lazy var buttons: [UIButton] = [comingSoonButton, everyoneWatchingButton, toptenTvButton, toptenMovieButton]
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
