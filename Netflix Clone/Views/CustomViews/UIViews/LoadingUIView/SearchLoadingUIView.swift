//
//  SearchLoadingUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit
import SkeletonView

class SearchLoadingUIView: UIView {
    
    //MARK: Declare Variables
    private let mainContainerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var containersArray = [UIStackView]()
    
    
    //MARK: - Load View
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureContainerBlocks()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    
    //MARK: - Setup Views
    private func setupView() {
        backgroundColor = .black
        addSubview(mainContainerStack)
        mainContainerStack.frame = bounds
    }
    
    private func configureContainerBlocks() {
        for _ in 0..<8 { addContainers() }
        containersArray.forEach {mainContainerStack.addArrangedSubview($0)}
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

        let secondBlockView = NFLoadingUIView()
        secondBlockView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        secondBlockView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        [firstBlockView, secondBlockView].forEach {blocksContainer.addArrangedSubview($0)}
        
        containersArray.append(blocksContainer)
    }
}


