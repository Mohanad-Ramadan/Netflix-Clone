//
//  ThreeButtonsUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 22/01/2024.
//

import UIKit

class ThreeButtonsUIView: UIView {
    protocol Delegate: AnyObject { func myListButtonTapped() }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureButtons()
        applyConstraints()
    }
    
    //MARK: - Configure Buttons
    private func configureButtons() {
        [myListButton, shareButton, rateButton].forEach {addSubview($0)}
        
        // setup custom images for buttons
        rateButton.configureButtonImageWith(UIImage(systemName: "paperplane")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
        shareButton.configureButtonImageWith(UIImage(systemName: "hand.thumbsup")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
        
        // configure Mylist button
        setupMyListButtonUI()
        myListButton.addTarget(self, action: #selector(listButtonAction), for: .touchUpInside)
    }
    
    //MARK: - Setup MyList Button
    @objc private func listButtonAction() {myListButtonTapped()}
    
    func myListButtonTapped() {
        Task {
            if await PersistenceDataManager.shared.isItemNewInList(item: media!) {
                try await PersistenceDataManager.shared.addToMyListMedia(media!)
                NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationKey), object: nil)
                // change button Image
                myListButton.configureButtonImageWith(UIImage(systemName: "checkmark")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
                // notify delegate that button been tapped
                delegate?.myListButtonTapped()
            } else {
                try await PersistenceDataManager.shared.deleteMediaFromList(media!)
                NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationKey), object: nil)
                // change button Image
                myListButton.configureButtonImageWith(UIImage(systemName: "plus")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
                // notify delegate that button been tapped
                delegate?.myListButtonTapped()
            }
        }
    }
    
    func setupMyListButtonUI() {
        Task {
            guard media != nil else {return}
            
            if await PersistenceDataManager.shared.isItemNewInList(item: media!){
                myListButton.configureButtonImageWith(UIImage(systemName: "plus")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
            } else {
                myListButton.configureButtonImageWith(UIImage(systemName: "checkmark")!, tinted: .white, width: 30, height: 30, placement: .top, padding: 5)
            }
        }
    }
    
    
    //MARK: - Constraints
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
    
    //MARK: - Declare Variables
    private var myListButton = NFPlainButton(title: "My List", fontSize: 12, fontWeight: .light, fontColorOnly: .lightGray)
    private var shareButton = NFPlainButton(title: "Share", fontSize: 12, fontWeight: .light, fontColorOnly: .lightGray)
    private var rateButton = NFPlainButton(title: "Rate", fontSize: 12, fontWeight: .light, fontColorOnly: .lightGray)
 
    var media: Media?
    weak var delegate: Delegate?
    
    required init?(coder: NSCoder) {fatalError()}

}
