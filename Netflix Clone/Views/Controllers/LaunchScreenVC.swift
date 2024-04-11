//
//  LaunchScreenVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/04/2024.
//

import UIKit
import SwiftUI

class LaunchScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserView()
        insertSpertatorView()
        setupSplashView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeSplashScreen()
    }
    
    func setupSplashView() {
        addChild(splashView)
        splashView.view.frame = view.bounds
        view.addSubview(splashView.view)
        splashView.didMove(toParent: self)
    }
    
    func setupUserView() {
        addChild(userView)
        userView.view.frame = view.bounds
        view.addSubview(userView.view)
        userView.rootView.delegate = self
        userView.didMove(toParent: self)
    }
    
    func removeSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2){
            UIView.animate(withDuration: 0.3) {
                self.splashView.view.alpha = 0
            } completion: { finish in
                self.splashView.view.removeFromSuperview()
                self.speratorBackGround.removeFromSuperview()
            }
            
        }
    }
    
    func insertSpertatorView() {
        view.addSubview(speratorBackGround)
        speratorBackGround.frame = view.bounds
        speratorBackGround.backgroundColor = .black
    }
    
    let speratorBackGround = UIView()
    let splashView = UIHostingController(rootView: LaunchScreenView())
    let userView = UIHostingController(rootView: UserView())
    let mainAppController = MainTabBarVC()
}

//MARK: - 
extension LaunchScreenVC: UserView.Delegate {
    func buttonDidTapped() {
        //
    }
}
