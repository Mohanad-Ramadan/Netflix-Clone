//
//  CastListVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/04/2024.
//

import UIKit

class CastListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureViews()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Configure Views
    func configureViews() {
        [bluryBackground,stackContainer,exitButtonBackground].forEach{view.addSubview($0)}
        
        bluryBackground.frame = view.bounds
        bluryBackground.addGrayBlurEffect()
        
        [].forEach{stackContainer.addArrangedSubview($0)}
        
        // setup exit Button
        exitButtonBackground.addSubview(exitButton)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc func exitButtonTapped() {dismiss(animated: true)}
    
    //MARK: - Constriants
    func applyConstraints() {
        // stackContainer
        stackContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        
        // exitButton constraints
        exitButtonBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButtonBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        exitButtonBackground.widthAnchor.constraint(equalToConstant: 50).isActive = true
        exitButtonBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        exitButton.centerXAnchor.constraint(equalTo: exitButtonBackground.centerXAnchor).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: exitButtonBackground.centerYAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalTo: exitButtonBackground.widthAnchor).isActive = true
        exitButton.heightAnchor.constraint(equalTo: exitButtonBackground.heightAnchor).isActive = true
        
    }
    
    //MARK: - Animate Stack's SubViews
    
    
    
    
    
    //MARK: - Declare Views & Variables
    let stackContainer : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollCastView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let exitButtonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let exitButton = NFSymbolButton(imageName: "xmark", imageSize: 17, imageColor: .black)
    let bluryBackground = UIView()
    
    var cast: Cast?
}

