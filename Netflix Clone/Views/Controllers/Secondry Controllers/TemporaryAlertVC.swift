//
//  TemproryAlertVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit

//MARK: Alert Cases
enum AlertType {
    case save , remove, connectivity
}

class TemporaryAlertVC: UIViewController {
    init(alertType: AlertType) {
        super.init(nibName: nil, bundle: nil)
        
        switch alertType {
        case .save: initSaveAlert()
        case .remove: initRemoveAlert()
        case .connectivity: initConnectionAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTapGesture()
        applyConstraints()
    }
    
    //MARK: - Configure VC
    func configureViews() {
        //containerView config
        view.addSubview(containerView)
        containerView.addSubview(messageLabel)
    }
    
    //MARK: - Setup Alert Type
    func initSaveAlert() {
        messageLabel.text = "Added to My List"
        containerView.backgroundColor = .darkGreen
        containerView.layer.shadowColor = UIColor.green.cgColor
        autoDismiss()
    }
    
    func initRemoveAlert() {
        messageLabel.text = "Removed from My List"
        containerView.backgroundColor = .darkRed
        containerView.layer.shadowColor = UIColor.red.cgColor
        autoDismiss()
    }
    
    func initConnectionAlert() {
        messageLabel.text = "❕ No internet connection"
        containerView.backgroundColor = .darkGray
        containerView.layer.shadowColor = UIColor.gray.cgColor
    }
    
    //MARK: - VC Dismiss function
    func autoDismiss() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.dismiss(animated: true)
        }
    }
    
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissVC() {
        alertTapped?()
        dismiss(animated: true)
    }

    //MARK: - constraints
    func applyConstraints(){
        let tabBarHeight = Constants.tabBarHeight + 10
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor, constant: 30),
            
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            messageLabel.widthAnchor.constraint(equalTo: messageLabel.widthAnchor),
            messageLabel.heightAnchor.constraint(equalTo: messageLabel.heightAnchor)
        ])
    }
    
    
    //MARK: - Declare Variables
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = NFBodyLabel(text: "", fontSize: 18, fontWeight: .semibold, textAlignment: .left, lines: 1, autoLayout: false)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowRadius = 2
        return label
    }()
    
    var alertTapped: (()->Void)?
    
    required init?(coder: NSCoder) {fatalError()}
}


//#Preview{TemporaryAlertVC(alertType: .save)}
