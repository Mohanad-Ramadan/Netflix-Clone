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
        configureButtons()
        applyConstraints()
        configureListButtonAction()
    }
    
    private func configureButtons() {
        [myListButton, shareButton, rateButton].forEach {addSubview($0)}
        
        myListButton.configureButtonImageWith(UIImage(systemName: "plus")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
        rateButton.configureButtonImageWith(UIImage(systemName: "paperplane")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
        shareButton.configureButtonImageWith(UIImage(systemName: "hand.thumbsup")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
    }
    
    private func configureListButtonAction() {
        myListButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
    }
    
    @objc private func listButtonTapped() {
        myListButton.configuration?.image = UIImage(systemName: "checkmark")?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFit)?.withTintColor(.white)
        myListButton.configuration?.imagePadding = 5
        Task {
            try await PersistenceDataManager.shared.addToMyListMedia(media!)
            NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationKey), object: nil)
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            myListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            myListButton.topAnchor.constraint(equalTo: topAnchor),
            myListButton.heightAnchor.constraint(equalTo: rateButton.heightAnchor),
            
            // Button 2
            rateButton.leadingAnchor.constraint(equalTo: myListButton.trailingAnchor, constant: 50),
            rateButton.bottomAnchor.constraint(equalTo: myListButton.bottomAnchor),
            rateButton.heightAnchor.constraint(equalTo: rateButton.heightAnchor),
            
            // Button 3
            shareButton.leadingAnchor.constraint(equalTo: rateButton.trailingAnchor, constant: 50),
            shareButton.bottomAnchor.constraint(equalTo: myListButton.bottomAnchor),
            shareButton.heightAnchor.constraint(equalTo: rateButton.heightAnchor),
        ])
    }
    
    private var myListButton = NFPlainButton(title: "My List", fontSize: 12, fontWeight: .light, fontColorOnly: .lightGray)
    private var shareButton = NFPlainButton(title: "Share", fontSize: 12, fontWeight: .light, fontColorOnly: .lightGray)
    private var rateButton = NFPlainButton(title: "Rate", fontSize: 12, fontWeight: .light, fontColorOnly: .lightGray)
 
    var media: Media?
    
    required init?(coder: NSCoder) {fatalError()}

}
