//
//  NewHotLoadingUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/03/2024.
//

import UIKit
import SkeletonView

class NewHotLoadingUIView: UIView {
    
    //MARK: Declare Variables
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let containerTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let firstBlockView = NFLoadingUIView()
    private let secondBlockView = NFLoadingUIView()
    private let thirdBlockView = NFLoadingUIView()
    
    private let firstBlockView2 = NFLoadingUIView()
    private let secondBlockView2 = NFLoadingUIView()
    private let thirdBlockView2 = NFLoadingUIView()
    
    var isScreenLarge: Bool = false
    
    
    //MARK: - Load View
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureblocks()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    
    //MARK: - Setup View
    private func setupView() {
        backgroundColor = .black
        addSubview(containerStack)
        containerStack.frame = bounds
        // Add containerOne and containerTwo to containerStack
        containerStack.addArrangedSubview(containerOne)
        containerStack.addArrangedSubview(containerTwo)
        // check if iphone screen is large
        if UIScreen.main.bounds.height > 667 { isScreenLarge = true }
        
        layoutIfNeeded()
    }
    
    private func configureblocks(){
        // block one constraints
        configureSubviews(firstView: firstBlockView, secondView: secondBlockView, thirdView: thirdBlockView, superView: containerOne)
        // block two constraints
        configureSubviews(firstView: firstBlockView2, secondView: secondBlockView2, thirdView: thirdBlockView2, superView: containerTwo)
    }
    
    private func configureSubviews(firstView: UIView ,secondView: UIView ,thirdView: UIView ,superView: UIStackView) {
        // Add subviews to the superview
        [firstView, secondView, thirdView].forEach{superView.addArrangedSubview($0)}
        
        // activate subviews constraints
        NSLayoutConstraint.activate([
            firstView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            firstView.heightAnchor.constraint(equalToConstant: isScreenLarge ? 200:180),
            
            secondView.widthAnchor.constraint(equalToConstant: 250),
            secondView.heightAnchor.constraint(equalToConstant: isScreenLarge ? 40:20),
            
            thirdView.widthAnchor.constraint(equalToConstant: 150),
            thirdView.heightAnchor.constraint(equalToConstant: isScreenLarge ? 20:15)
        ])
    }
    
}

