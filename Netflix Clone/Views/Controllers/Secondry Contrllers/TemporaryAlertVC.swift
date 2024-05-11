//
//  TemproryAlertVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit

class TemporaryAlertVC: UIViewController {
    init(alertTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
//        configureTapGesture()
        applyConstraints()
        autoDismiss()
    }
    
    //MARK: - Configure VC
    func configureViews() {
        //containerView config
        view.addSubview(containerView)
        containerView.addSubview(messageLabel)
        messageLabel.text = alertTitle!
    }
    
    //MARK: - VC Dismiss function
    func autoDismiss() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.dismiss(animated: true)
        }
    }
    
//    func configureTapGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissVC() { dismiss(animated: true) }

    //MARK: - constraints
    func applyConstraints(){
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -7),
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
        let green = UIColor(red: 5/255.0, green: 148/255.0, blue: 0/255.0, alpha: 1.000)
        view.backgroundColor = green
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = green.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
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
    var alertTitle: String?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#Preview{
    TemporaryAlertVC(alertTitle: "hello")
}
