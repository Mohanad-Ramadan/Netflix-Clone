//
//  MyNetflixRowUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

class MyNetflixRowUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(label)
        addSubview(button)
        configureButtonImage()
        applyConstraints()
    }
    
    @objc func chevronButtonTapped() {
        // Find the nearest view controller
        var responder: UIResponder? = self
        while responder != nil && !(responder is UIViewController) {
            responder = responder?.next
        }
        
        // Check if the responder is a view controller
        if let viewController = responder as? UIViewController {
            // Use the view controller to navigate
            viewController.navigationController?.pushViewController(DownloadVC(), animated: true)
        }
    }
    
    private func configureButtonImage() {
        button.configureButtonImageWith(UIImage(systemName: "chevron.right")!, tinted: .white, width: 12, height: 12, placement: .trailing, padding: 5)
        button.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Label Constraints
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.widthAnchor.constraint(equalTo: label.widthAnchor),
            label.heightAnchor.constraint(equalTo: label.heightAnchor),
            
            // Button Constraints
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            button.widthAnchor.constraint(equalTo: button.widthAnchor),
            button.heightAnchor.constraint(equalTo: button.heightAnchor)
        ])
        
    }

    private let label = NFBodyLabel(text: "My List", fontSize: 20, fontWeight: .bold)
//    private let button = NFSymbolButton(imageName: "chevron.right", imageSize: 20)
    private let button = NFPlainButton(title: "See All", fontSize: 16, fontWeight: .semibold)
    
    required init?(coder: NSCoder) {fatalError()}
}
