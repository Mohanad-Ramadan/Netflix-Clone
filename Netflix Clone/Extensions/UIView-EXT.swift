//
//  UIView-EXT.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/03/2024.
//

import UIKit

extension UIView {
    func addGrayBlurEffect() {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // Add the blur view as a subview
        blurView.frame = bounds
        addSubview(blurView)
        
        // Ensure that the blur view matches the size of the parent view
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}
