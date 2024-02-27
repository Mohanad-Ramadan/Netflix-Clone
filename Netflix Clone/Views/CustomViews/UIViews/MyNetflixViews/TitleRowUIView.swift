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
        addSubview(symbol)
        addSubview(label)
        addSubview(button)
        
        button.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        
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
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Symbol Constraints
            symbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            symbol.topAnchor.constraint(equalTo: topAnchor),
            symbol.widthAnchor.constraint(equalToConstant: 40),
            symbol.heightAnchor.constraint(equalToConstant: 40),
            
            // Label Constraints
            label.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: symbol.centerYAnchor),
            label.widthAnchor.constraint(equalTo: label.widthAnchor),
            label.heightAnchor.constraint(equalTo: label.heightAnchor),
            
            // Button Constraints
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            button.centerYAnchor.constraint(equalTo: symbol.centerYAnchor),
            button.widthAnchor.constraint(equalTo: button.widthAnchor),
            button.heightAnchor.constraint(equalTo: button.heightAnchor)
        ])
        
    }
    
    private let symbol: UIImageView = {
        let symbol = UIImageView()
        symbol.image = UIImage(systemName: "arrow.down")
        symbol.contentMode = .center
        symbol.backgroundColor = UIColor(red: 73/255.0, green: 105/255.0, blue: 228/255.0, alpha: 1.000)
        symbol.layer.cornerRadius = 20
        symbol.tintColor = .white
        symbol.translatesAutoresizingMaskIntoConstraints = false
        return symbol
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Downloads"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
