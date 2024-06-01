//
//  TemproryAlertVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit
import Combine

//MARK: Alert Cases
enum AlertType { case save , remove, connectivity }


class TemporaryAlertVC: UIViewController {
    
    //MARK: Declare Variables
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = NFBodyLabel(text: "", fontSize: 16, fontWeight: .semibold, textAlignment: .left, lines: 1, autoLayout: false)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowRadius = 2
        return label
    }()
    
    var alertTapped: (()->Void)?
    var representedVC: UIViewController!
    var networkConnection: AnyCancellable?
    
    
    //MARK: - Load View
    init(alertType: AlertType, appearOn vcBelow: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.representedVC = vcBelow
        switch alertType {
        case .save: initSaveAlert()
        case .remove: initRemoveAlert()
        case .connectivity: initConnectionAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Setup View
    func configureViews() {
        //containerView config
        view.addSubview(containerView)
        containerView.addSubview(messageLabel)
    }
    
    //MARK: - Setup Alert Types
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
        configureTapGesture()
        connectionRestoredAction()
    }
    
    //MARK: - Dismiss VC
    func connectionRestoredAction() {
        var reconnectCount = 0  // count to solve repeated true connection value
        networkConnection = NetworkMonitor.shared.isConnected
            .sink{ connected in
                guard connected, reconnectCount == 0 else {return}
                reconnectCount += 1
                DispatchQueue.main.async { [weak self] in
                    self?.reloadRepresentedVC()
                    self?.dismiss(animated: true)
                }
            }
    }
    
    func reloadRepresentedVC() {
        representedVC.loadViewIfNeeded()
        representedVC.viewDidLoad()
    }
    
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissVC() {
        reloadRepresentedVC()
        dismiss(animated: true)
    }
    
    // for save and remove alerts
    func autoDismiss() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.dismiss(animated: true)
        }
    }

    //MARK: - Constraints
    func containerBottomAnchor() -> NSLayoutConstraint {
        var tabBarHeight = representedVC.navigationController?.tabBarController?.tabBar.bounds.height
        let isTabBarHidden = representedVC.tabBarController?.tabBar.isHidden ?? false
        
        if tabBarHeight == nil || isTabBarHidden {
            let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            return bottomConstraint
        } else {
            tabBarHeight! += 10
            let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight!)
            return bottomConstraint
        }
    }
    
    func applyConstraints(){
        NSLayoutConstraint.activate([
            // containerView constraints
            containerBottomAnchor(),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor, constant: 30),
            
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            messageLabel.widthAnchor.constraint(equalTo: messageLabel.widthAnchor),
            messageLabel.heightAnchor.constraint(equalTo: messageLabel.heightAnchor)
        ])
    }
    
}


//#Preview{TemporaryAlertVC(alertType: .save)}
