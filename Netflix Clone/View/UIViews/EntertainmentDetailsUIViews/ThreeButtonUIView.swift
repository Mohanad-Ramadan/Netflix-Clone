//
//  ThreeButtonUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 22/01/2024.
//

import UIKit

class ThreeButtonUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(myListButton)
        addSubview(shareButton)
        addSubview(rateButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            myListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            myListButton.topAnchor.constraint(equalTo: topAnchor),
            myListButton.heightAnchor.constraint(equalTo: rateButton.heightAnchor),
            
            // Button 2
            shareButton.leadingAnchor.constraint(equalTo: myListButton.trailingAnchor, constant: 120),
            shareButton.topAnchor.constraint(equalTo: myListButton.topAnchor),
            shareButton.heightAnchor.constraint(equalTo: rateButton.heightAnchor),
            
            // Button 3
            rateButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 120),
            rateButton.topAnchor.constraint(equalTo: myListButton.topAnchor),
            rateButton.heightAnchor.constraint(equalTo: rateButton.heightAnchor),
        ])
    }
    
    private func createButton(title: String, image: UIImage?) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .light)
            outgoing.foregroundColor = UIColor.lightGray
            return outgoing
        }
        
        configuration.image = image!.sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFit)
        configuration.imagePlacement = .top
        configuration.imagePadding = 10
        
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var myListButton: UIButton = createButton(title: "My list", image: UIImage(systemName: "plus"))
    private lazy var shareButton: UIButton = createButton(title: "Share", image: UIImage(systemName: "paperplane"))
    private lazy var rateButton: UIButton = createButton(title: "Rate", image: UIImage(systemName: "hand.thumbsup"))

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
