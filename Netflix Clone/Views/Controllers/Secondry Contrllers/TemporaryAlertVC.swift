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
        configureTapGesture()
        applyConstraints()
    }
    
    func configureViews() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        //containerView config
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle!
    }
    
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissVC() { dismiss(animated: true) }
    
    func applyConstraints(){
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 30),
            containerView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            titleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
    
    
    //MARK: - Declare Variables
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .fadedBlack
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.2).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel = NFBodyLabel(text: "", fontSize: 18, fontWeight: .semibold, textAlignment: .center, lines: 1, autoLayout: false)
    var alertTitle: String?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#Preview{
    TemporaryAlertVC(alertTitle: "hello")
}
