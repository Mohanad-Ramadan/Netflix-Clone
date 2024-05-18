//
//  SkeletonLoadingUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/11/2023.
//

import UIKit
import SkeletonView

class HomeLoadingUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        [headerImageView,headerText,headerButton,postersViewsHeader,posterView1,posterView2,posterView3,posterView4]
        .forEach {addSubview($0)}
        applyConstraints()
    }

    private let headerImageView = NFLoadingUIView()
    
    private let headerText = NFLoadingUIView()
    
    private let headerButton = NFLoadingUIView()
    
    private let postersViewsHeader = NFLoadingUIView()
    
    private let posterView1 = NFLoadingUIView()
    
    private let posterView2 = NFLoadingUIView()
    
    private let posterView3 = NFLoadingUIView()
    
    private let posterView4 = NFLoadingUIView()
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
        
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant: UIScreen.main.bounds.width/3),
            headerImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 250),
            headerImageView.widthAnchor.constraint(equalToConstant: 200),

            headerText.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            headerText.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10),
            headerText.widthAnchor.constraint(equalToConstant: 300),
            headerText.heightAnchor.constraint(equalToConstant: 25),
        
            headerButton.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            headerButton.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 10),
            headerButton.widthAnchor.constraint(equalToConstant: 100),
            headerButton.heightAnchor.constraint(equalToConstant: 40),
        
            postersViewsHeader.topAnchor.constraint(equalTo: headerButton.bottomAnchor, constant: 60),
            postersViewsHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            postersViewsHeader.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2 - 10),
            postersViewsHeader.heightAnchor.constraint(equalToConstant: 25),
        
        
            posterView1.topAnchor.constraint(equalTo: postersViewsHeader.bottomAnchor, constant: 5),
            posterView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            posterView1.heightAnchor.constraint(equalToConstant: 180),
            posterView1.widthAnchor.constraint(equalToConstant: 130),
            
            posterView2.topAnchor.constraint(equalTo: postersViewsHeader.bottomAnchor, constant: 5),
            posterView2.leadingAnchor.constraint(equalTo: posterView1.trailingAnchor, constant: 8),
            posterView2.heightAnchor.constraint(equalToConstant: 180),
            posterView2.widthAnchor.constraint(equalToConstant: 130),
            
            posterView3.topAnchor.constraint(equalTo: postersViewsHeader.bottomAnchor, constant: 5),
            posterView3.leadingAnchor.constraint(equalTo: posterView2.trailingAnchor, constant: 8),
            posterView3.heightAnchor.constraint(equalToConstant: 180),
            posterView3.widthAnchor.constraint(equalToConstant: 130),
            
            posterView4.topAnchor.constraint(equalTo: postersViewsHeader.bottomAnchor, constant: 5),
            posterView4.leadingAnchor.constraint(equalTo: posterView3.trailingAnchor, constant: 8),
            posterView4.heightAnchor.constraint(equalToConstant: 180),
            posterView4.widthAnchor.constraint(equalToConstant: 130)
        ])
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

