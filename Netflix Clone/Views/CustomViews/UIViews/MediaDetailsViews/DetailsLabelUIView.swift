//
//  DetailsLabelUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/02/2024.
//

import UIKit

class DetailsLabelUIView: UIView {
    
    //MARK: Declare Variables
    let newLabel = NFBodyLabel(color: .green.withAlphaComponent(0.8), fontSize: 14,fontWeight: .medium)
    let runtimeLabel = NFBodyLabel(fontSize: 15, fontWeight: .medium)
    let adultIcon = NFImageView(image: ._18Icon)
    let dateLabel = NFBodyLabel(fontSize: 15, fontWeight: .medium)
    let otherIcons = NFImageView(image: .otherIcons)
    
    
    //MARK: - Load View
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
    
    required init?(coder: NSCoder) {fatalError()}
    
    
    //MARK: - Constraints
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
    
}
