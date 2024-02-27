//
//  DetailsLabelUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/02/2024.
//

import UIKit

class DetailsLabelUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(newLabel)
        addSubview(dateLabel)
        addSubview(adultIcon)
        addSubview(runtimeLabel)
        addSubview(otherIcons)
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            newLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            newLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            newLabel.heightAnchor.constraint(equalTo: newLabel.heightAnchor),
            
            // Button 2
            dateLabel.leadingAnchor.constraint(equalTo: newLabel.trailingAnchor, constant: 7),
            dateLabel.centerYAnchor.constraint(equalTo: newLabel.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalTo: newLabel.heightAnchor),
            
            // Button 3
            adultIcon.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor,constant: 3),
            adultIcon.centerYAnchor.constraint(equalTo: newLabel.centerYAnchor),
            adultIcon.heightAnchor.constraint(equalToConstant: 20),
            adultIcon.widthAnchor.constraint(equalToConstant: 25),
            
            // Button 3
            runtimeLabel.leadingAnchor.constraint(equalTo: adultIcon.trailingAnchor,constant: 5),
            runtimeLabel.centerYAnchor.constraint(equalTo: newLabel.centerYAnchor),
            runtimeLabel.heightAnchor.constraint(equalTo: newLabel.heightAnchor),
            
            // Button 3
            otherIcons.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor,constant: 5),
            otherIcons.centerYAnchor.constraint(equalTo: newLabel.centerYAnchor),
            otherIcons.heightAnchor.constraint(equalToConstant: 15),
            otherIcons.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    let newLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green.withAlphaComponent(0.8)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let adultIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "+18Icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let otherIcons: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "otherIcons")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
