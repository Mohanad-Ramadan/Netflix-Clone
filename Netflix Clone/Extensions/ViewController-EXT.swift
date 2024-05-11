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
        DispatchQueue.main.async {
            let alertVC = NFAlertVC(alertTitle: alertTitle , messageText: messageText)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentDefaultError() {
        DispatchQueue.main.async {
            let alertVC = NFAlertVC(alertTitle: "Opps",
                                    messageText: "Connection Lost. Please check your Internet connection")
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentTemporaryAlert(alertTitle: String) {
        DispatchQueue.main.async {
            let alertVC = TemporaryAlertVC(alertTitle: alertTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .coverVertical
            self.present(alertVC, animated: true)
        }
    }
}
