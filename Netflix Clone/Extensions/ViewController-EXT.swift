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
    
    func pushInMainThreadTo(_ viewController: UIViewController){
        DispatchQueue.main.async { [weak self] in
            let vc = viewController
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
