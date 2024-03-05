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
        configureMainViews()
        activateSkeletonEffect()
    }
    
    private func activateSkeletonEffect() {
        [firstBlockView,secondBlockView,thirdBlockView, firstBlockView2,secondBlockView2,thirdBlockView2]
            .forEach{ blocks in
            blocks.isSkeletonable = true
            blocks.showAnimatedGradientSkeleton()
        }
    }
    
    //MARK: - Configure Views
    private func setupView() {
        backgroundColor = .black
        [containerOne,containerTwo].forEach{ subview in
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureMainViews(){
        let containerOneConstraints = [
            containerOne.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor ,constant: 10),
            containerOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            containerOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            containerOne.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let containerTwoConstraints = [
            containerTwo.topAnchor.constraint(equalTo: containerOne.bottomAnchor, constant: 30),
            containerTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            containerTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            containerTwo.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(containerOneConstraints)
        NSLayoutConstraint.activate(containerTwoConstraints)
        
        configureSubviews(firstView: firstBlockView, secondView: secondBlockView, thirdView: thirdBlockView, superView: containerOne)
        
        configureSubviews(firstView: firstBlockView2, secondView: secondBlockView2, thirdView: thirdBlockView2, superView: containerTwo)
    }
    
    private func configureSubviews(firstView: UIView ,secondView: UIView ,thirdView: UIView ,superView: UIView) {
        // Add subviews to the superview
        [firstView, secondView, thirdView].forEach{ subview in
            superView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // activate subviews constraints
        let firstBlockConstraints = [
            firstView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            firstView.topAnchor.constraint(equalTo: superView.topAnchor),
            firstView.widthAnchor.constraint(equalTo: superView.widthAnchor),
            firstView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let secondBlockConstraints = [
            secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
            secondView.widthAnchor.constraint(equalToConstant: 250),
            secondView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let thirdBlockConstraints = [
            thirdView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10),
            thirdView.widthAnchor.constraint(equalToConstant: 150),
            thirdView.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(firstBlockConstraints)
        NSLayoutConstraint.activate(secondBlockConstraints)
        NSLayoutConstraint.activate(thirdBlockConstraints)
    }
    
    //MARK: - Declare UIElements
    private let containerOne = UIView()
    private let containerTwo = UIView()
    
    private let firstBlockView = NFLoadingUIView()
    private let secondBlockView = NFLoadingUIView()
    private let thirdBlockView = NFLoadingUIView()
    
    private let firstBlockView2 = NFLoadingUIView()
    private let secondBlockView2 = NFLoadingUIView()
    private let thirdBlockView2 = NFLoadingUIView()
    
    
    
    required init?(coder: NSCoder) {fatalError()}
}


//#Preview{
//    NewHotLoadingUIView()
//}
