//
//  SeasonSelectHeaderView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/03/2024.
//

import UIKit

class SeasonSelectHeaderView: UIView {
    
    protocol Delegate: AnyObject {func listButtonTapped()}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        applyConstraints()
        setupListButtonAction()
    }
    
    private func configureView() {
        backgroundColor = .clear
        [seasonLabel,listSeasonsButton,infoButton].forEach{addSubview($0)}
    }
    
    private func setupListButtonAction() {
        listSeasonsButton.addTarget(self, action: #selector(showSeasonsView), for: .touchUpInside)
    }
    
    @objc func showSeasonsView() {delegate?.listButtonTapped()}
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // seasonLabel Constraints
            seasonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            seasonLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            seasonLabel.widthAnchor.constraint(equalTo: seasonLabel.widthAnchor),
            seasonLabel.heightAnchor.constraint(equalTo: seasonLabel.heightAnchor),
            
            // Button Constraints
            listSeasonsButton.leadingAnchor.constraint(equalTo: seasonLabel.trailingAnchor, constant: 10),
            listSeasonsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            listSeasonsButton.widthAnchor.constraint(equalTo: listSeasonsButton.widthAnchor),
            listSeasonsButton.heightAnchor.constraint(equalTo: listSeasonsButton.heightAnchor),
            
            
            // Button Constraints
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            infoButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoButton.widthAnchor.constraint(equalTo: infoButton.widthAnchor),
            infoButton.heightAnchor.constraint(equalTo: infoButton.heightAnchor)
        ])
        
    }
    
    let seasonLabel = NFBodyLabel(text: "Seasons 1", fontSize: 16)
    private let listSeasonsButton = NFSymbolButton(imageName: "chevron.down", imageSize: 10)
    private let infoButton = NFSymbolButton(imageName: "info.circle.fill", imageSize: 25, imageColor: .lightGray)
    
    weak var delegate: Delegate?
    
    required init?(coder: NSCoder) {fatalError()}
}
