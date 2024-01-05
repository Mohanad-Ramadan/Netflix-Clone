//
//  CategoryButtonsUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/11/2023.
//

import UIKit

class CategoryButtonsUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(tvShowsButton)
        addSubview(moviesButton)
        addSubview(categoriesButton)
        applyConstraints()
    }
    
    
    private let tvShowsButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "TV Shows"
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        configuration.background.strokeWidth = 1
        configuration.background.strokeColor = UIColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.5)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .semibold)
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    private let moviesButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Movies"
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        configuration.background.strokeWidth = 1
        configuration.background.strokeColor = UIColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.5)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .semibold)
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    private let categoriesButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Categories"
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "chevron.down")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.cornerStyle = .capsule
        configuration.background.strokeWidth = 1
        configuration.background.strokeColor = UIColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.5)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8.5, leading: 15, bottom: 8.5, trailing: 15)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .semibold)
            return outgoing
        }

        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            // Button 1
            tvShowsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            tvShowsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tvShowsButton.widthAnchor.constraint(equalTo: tvShowsButton.widthAnchor),
            tvShowsButton.heightAnchor.constraint(equalTo: tvShowsButton.heightAnchor),
            
            // Button 2
            moviesButton.leadingAnchor.constraint(equalTo: tvShowsButton.trailingAnchor, constant: 8),
            moviesButton.topAnchor.constraint(equalTo: tvShowsButton.topAnchor),
            moviesButton.widthAnchor.constraint(equalTo: moviesButton.widthAnchor),
            moviesButton.heightAnchor.constraint(equalTo: moviesButton.heightAnchor),
            
            // Button 3
            categoriesButton.leadingAnchor.constraint(equalTo: moviesButton.trailingAnchor, constant: 8),
            categoriesButton.topAnchor.constraint(equalTo: tvShowsButton.topAnchor),
            categoriesButton.widthAnchor.constraint(equalTo: categoriesButton.widthAnchor),
            categoriesButton.heightAnchor.constraint(equalTo: categoriesButton.heightAnchor)
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

