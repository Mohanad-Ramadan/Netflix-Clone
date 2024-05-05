//
//  NFAlertVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 05/05/2024.
//

import UIKit

class NFAlertVC: UIViewController {
    init(alertTitle: String, messageText: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.messageText = messageText
        self.buttonTitle = buttonTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        configureViews()
        applyConstraints()
    }
    
    func configureViews(){
        //containerView config
        view.addSubview(containerView)
        containerView.addSubview(stackContainerView)
        //titleLabel config
        stackContainerView.addArrangedSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        //messageLabel config
        stackContainerView.addArrangedSubview(messageLabel)
        messageLabel.text = messageText ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        //actionButton config
        stackContainerView.addArrangedSubview(actionButton)
        actionButton.configuration?.title = buttonTitle
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    @objc func dismissVC() { dismiss(animated: true) }
    
    func applyConstraints(){
        let padding:CGFloat = 10
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            stackContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            stackContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            stackContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            stackContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    
    //MARK: - Declare Variables
    let containerView = NFAlertContainerView()
    
    let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel = NFTitleLabel(text: "Opps", textAlignment: .center, lines: 0, autoLayout: true)
    let messageLabel = NFBodyLabel(text: "", color: .lightGray , fontSize: 17, fontWeight: .regular, textAlignment: .center, lines: 0, autoLayout: true)
    let actionButton = NFFilledButton(title: "Ok", fontSize: 20, fontWeight: .semibold, cornerStyle: .medium, autoLayout: true)
    
    var alertTitle: String?
    var messageText: String?
    var buttonTitle: String?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

