//
//  SeasonsListVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/03/2024.
//

import UIKit

class SeasonsListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureViews()
        applyConstraints()
    }
    
    init(seasonsCount: Int) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Configure Views
    func configureViews() {
        [bluryBackground, stackContainer, exitButtonBackground, exitButton].forEach{view.addSubview($0)}
        bluryBackground.addGrayBlurEffect()
        
        
    }
    
    private func applyConstraints() {
        bluryBackground.frame = view.bounds
        
        stackContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackContainer.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -10).isActive = true
        
        exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalTo: exitButton.widthAnchor).isActive = true
        exitButton.heightAnchor.constraint(equalTo: exitButton.heightAnchor).isActive = true
        
        exitButtonBackground.centerXAnchor.constraint(equalTo: exitButton.centerXAnchor).isActive = true
        exitButtonBackground.centerYAnchor.constraint(equalTo: exitButton.centerYAnchor).isActive = true
        exitButtonBackground.widthAnchor.constraint(equalToConstant: 50).isActive = true
        exitButtonBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func createListViews(with totalSeasons: Int) {
        
    }
    
    //MARK: - Declare Views & Variables
    let seasonsListView = NFPlainButton(title: "Season 1", fontSize: 26, fontWeight: .regular, fontColorOnly: .gray)
    
    let exitButton = NFSymbolButton(imageName: "xmark", imageSize: 20, imageColor: .black)
    
    let exitButtonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 60
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bluryBackground = UIView()
    
    let stackContainer : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.backgroundColor = .carrot
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let seasonsButtons = [NFPlainButton]()
}


extension UIView {
    func addGrayBlurEffect() {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // Add the blur view as a subview
        blurView.frame = bounds
        addSubview(blurView)
        
        // Ensure that the blur view matches the size of the parent view
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
