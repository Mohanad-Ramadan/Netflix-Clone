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
        [tvShowsButton, moviesButton, categoriesButton].forEach {addSubview($0)}
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
    
    private var tvShowsButton = NFPlainButton(barButtontitle: "TV Shows")
    private var moviesButton = NFPlainButton(barButtontitle: "Movies")
    private var categoriesButton = NFPlainButton(barButtontitle: "Categories", image: UIImage(systemName: "chevron.down"))
    
    required init?(coder: NSCoder) {fatalError()}
}

