//
//  NFAlertContainerView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 05/05/2024.
//

import UIKit

class NFAlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        backgroundColor = .darkGray.darker
        layer.cornerRadius = 16
        layer.borderWidth = 0.1
        layer.borderColor = UIColor.darkGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
