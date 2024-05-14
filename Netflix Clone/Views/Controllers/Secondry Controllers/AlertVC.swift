//
//  AlertVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 05/05/2024.
//

import UIKit

class AlertVC: UIViewController {
    init(alertTitle: String, messageText: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.messageText = messageText
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
        titleLabel.text = alertTitle!
        
        //messageLabel config
        stackContainerView.addArrangedSubview(messageLabel)
        messageLabel.text = messageText!
        
        //actionButton config
        stackContainerView.addArrangedSubview(actionButton)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
    }
    
    @objc func dismissVC() { dismiss(animated: true) }
    
    func applyConstraints(){
        let padding:CGFloat = 22
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
            
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        stackContainerView.setCustomSpacing(-15, after: titleLabel)
    }
    
    
    //MARK: - Declare Variables
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .fadedBlack
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.3).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel = NFTitleLabel(text: "Opps", textAlignment: .center, lines: 0, autoLayout: true)
    let messageLabel = NFBodyLabel(text: "", color: .lightGray , fontSize: 17, fontWeight: .regular, textAlignment: .center, lines: 0, autoLayout: true)
    
    lazy var actionButton = NFFilledButton(title: "Ok", foregroundColor: .white, backgroundColor: .darkRed, fontSize: 20, fontWeight: .semibold, autoLayout: true)
    
    var alertTitle: String?
    var messageText: String?
    var buttonTitle: String?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview{
    AlertVC(alertTitle: "Opps", messageText: "somthing went wrong please try again")
}
