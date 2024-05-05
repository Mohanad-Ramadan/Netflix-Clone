//
//  NewHotLoadingUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/03/2024.
//

import UIKit
import SkeletonView

class NewHotLoadingUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureblocks()
        activateSkeletonEffect()
    }
    
    //MARK: - Configure Views
    private func setupView() {
        backgroundColor = .black
        addSubview(containerStack)
        [containerOne,containerTwo].forEach{
            containerStack.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        }
    }
    
    private func activateSkeletonEffect() {
        [firstBlockView,secondBlockView,thirdBlockView, firstBlockView2,secondBlockView2,thirdBlockView2]
            .forEach{ blocks in
            blocks.isSkeletonable = true
            blocks.showAnimatedGradientSkeleton()
        }
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
            firstView.heightAnchor.constraint(equalToConstant: 200),
            
            secondView.widthAnchor.constraint(equalToConstant: 250),
            secondView.heightAnchor.constraint(equalToConstant: 40),
            
            thirdView.widthAnchor.constraint(equalToConstant: 150),
            thirdView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: - Declare UIElements
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let containerTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let firstBlockView = NFLoadingUIView()
    private let secondBlockView = NFLoadingUIView()
    private let thirdBlockView = NFLoadingUIView()
    
    private let firstBlockView2 = NFLoadingUIView()
    private let secondBlockView2 = NFLoadingUIView()
    private let thirdBlockView2 = NFLoadingUIView()
    
    
    
    required init?(coder: NSCoder) {fatalError()}
}

