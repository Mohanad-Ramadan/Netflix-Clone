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
        createListViews(with: 1)
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Configure Views
    func configureViews() {
        [bluryBackground, containerView, exitButtonBackground].forEach{view.addSubview($0)}
        
        [upperPaddingView, stackContainer, lowerPaddingView].forEach{containerView.addSubview($0)}
        
        exitButtonBackground.addSubview(exitButton)
        
        bluryBackground.addGrayBlurEffect()
    }
    
    private func createListViews(with totalSeasons: Int) {
        for season in 1...totalSeasons {
            let seasonView = NFPlainButton(title: "Season \(season)", fontSize: 18, fontWeight: .regular, fontColorOnly: .lightGray)
            seasonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            seasonsButtons.append(seasonView)
            stackContainer.addArrangedSubview(seasonView)
        }
    }
    
    private func configureButtonsTarget() {
        
    }
    
    private func animateTappedButton(){
        
    }
    
    private func applyConstraints() {
        // background frame
        bluryBackground.frame = view.bounds
        
        // upper portion of the vc constraints
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: exitButtonBackground.topAnchor).isActive = true
        
        // containerView subviews constriants
        upperPaddingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        upperPaddingView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 20).isActive = true
        upperPaddingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        upperPaddingView.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height*0.5).isActive = true
        
        stackContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        stackContainer.topAnchor.constraint(equalTo: upperPaddingView.bottomAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(lessThanOrEqualTo: containerView.centerYAnchor).isActive = true
        stackContainer.heightAnchor.constraint(equalTo: stackContainer.heightAnchor).isActive = true
        stackContainer.bottomAnchor.constraint(equalTo: lowerPaddingView.topAnchor).isActive = true
        
        lowerPaddingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lowerPaddingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        lowerPaddingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lowerPaddingView.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height*0.5).isActive = true
        
        // exitButton constraints
        exitButtonBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButtonBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        exitButtonBackground.widthAnchor.constraint(equalToConstant: 50).isActive = true
        exitButtonBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        exitButton.centerXAnchor.constraint(equalTo: exitButtonBackground.centerXAnchor).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: exitButtonBackground.centerYAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalTo: exitButton.widthAnchor).isActive = true
        exitButton.heightAnchor.constraint(equalTo: exitButton.heightAnchor).isActive = true
        
        
    }
    
    //MARK: - Declare Views & Variables
    let exitButton = NFSymbolButton(imageName: "xmark", imageSize: 17, imageColor: .black)
    
    let exitButtonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bluryBackground = UIView()
    
    let lowerPaddingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let upperPaddingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackContainer : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var seasonsButtons = [NFPlainButton]()
}

