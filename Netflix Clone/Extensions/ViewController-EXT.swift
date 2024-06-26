//
//  ViewController-EXT.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/02/2024.
//

import UIKit

extension UIViewController {
    
    func presentInMainThread(_ viewController: UIViewController){
        DispatchQueue.main.async { [weak self] in
            let vc = viewController
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.present(vc, animated: true)
        }
    }
    
    func presentAsRoot(_ viewController: UIViewController){
        DispatchQueue.main.async { [weak self] in
            let vc = viewController
            vc.hidesBottomBarWhenPushed = true
            let navigationController = UINavigationController(rootViewController: vc)
            self?.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func pushInMainThreadTo(_ viewController: UIViewController, animated: Bool = true){
        DispatchQueue.main.async { [weak self] in
            let vc = viewController
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func presentNFAlert(alertTitle: String = "Opps!", messageText: String){
        DispatchQueue.main.async { [weak self] in
            let alertVC = AlertVC(alertTitle: alertTitle , messageText: messageText)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self?.present(alertVC, animated: true)
        }
    }
    
    func presentTemporaryAlert(alertType: AlertType) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            let alertVC = TemporaryAlertVC(alertType: alertType, appearOn: self)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .coverVertical
            self.present(alertVC, animated: true)
        }
    }
}

