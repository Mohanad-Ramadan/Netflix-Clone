//
//  SearchLoadingUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit
import SkeletonView

class SearchLoadingUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureContainerBlocks()
    }
    
    //MARK: - Configure Views
    private func setupView() {
        backgroundColor = .black
        addSubview(mainContainerStack)
        mainContainerStack.frame = bounds
    }
    
    private func configureContainerBlocks() {
        for _ in 0..<8 { addContainers() }
        containersArray.forEach {mainContainerStack.addArrangedSubview($0)}
    }
    
    private func activateSkeletonEffect(viewOne: UIView, viewTwo: UIView, viewThree: UIView) {
        [viewOne,viewTwo,viewThree].forEach{ blocks in
            blocks.isSkeletonable = true
            blocks.showAnimatedGradientSkeleton()
        }
    }
    
    private func addContainers() {
        let blocksContainer: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 20
            return stackView
        }()
        
        let firstBlockView = NFLoadingUIView()
        firstBlockView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        firstBlockView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        firstBlockView.isSkeletonable = true
        firstBlockView.showAnimatedGradientSkeleton()

        let secondBlockView = NFLoadingUIView()
        secondBlockView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        secondBlockView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        secondBlockView.isSkeletonable = true
        secondBlockView.showAnimatedGradientSkeleton()
        
        [firstBlockView, secondBlockView].forEach {
            blocksContainer.addArrangedSubview($0)
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
        
        containersArray.append(blocksContainer)
    }
    
    //MARK: - Declare UIElements
    private let mainContainerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var containersArray = [UIStackView]()
    
    required init?(coder: NSCoder) {fatalError()}
}


