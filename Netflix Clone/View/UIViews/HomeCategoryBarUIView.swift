//
//  HomeCategoryBarUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/11/2023.
//

import UIKit

class HomeCategoryBarUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(tvShowsButton)
        addSubview(moviesButton)
        addSubview(categoriesButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            tvShowsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            tvShowsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tvShowsButton.heightAnchor.constraint(equalTo: categoriesButton.heightAnchor),
            
            // Button 2
            moviesButton.leadingAnchor.constraint(equalTo: tvShowsButton.trailingAnchor, constant: 8),
            moviesButton.topAnchor.constraint(equalTo: tvShowsButton.topAnchor),
            moviesButton.heightAnchor.constraint(equalTo: categoriesButton.heightAnchor),
            
            // Button 3
            categoriesButton.leadingAnchor.constraint(equalTo: moviesButton.trailingAnchor, constant: 8),
            categoriesButton.topAnchor.constraint(equalTo: tvShowsButton.topAnchor),
            categoriesButton.heightAnchor.constraint(equalTo: categoriesButton.heightAnchor),
        ])
    }
    
    private func createButton(title: String, image: UIImage? = nil) -> UIButton {
           let button = UIButton()
           var configuration = UIButton.Configuration.filled()
           configuration.title = title
           configuration.baseBackgroundColor = .clear
           configuration.baseForegroundColor = .white
           configuration.cornerStyle = .capsule
           configuration.background.strokeWidth = 1
           configuration.background.strokeColor = UIColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.5)
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

       private lazy var tvShowsButton: UIButton = createButton(title: "TV Shows")
       private lazy var moviesButton: UIButton = createButton(title: "Movies")
       private lazy var categoriesButton: UIButton = createButton(title: "Categories", image: UIImage(systemName: "chevron.down"))

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

