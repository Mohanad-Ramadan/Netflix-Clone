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
        setupMainTabController()
        setupUserView()
        insertSpertatorView()
        setupSplashView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeSplashScreen()
    }
    
    //MARK: - Configure TabBarController
    func setupMainTabController() {
        addChild(mainAppController)
        mainAppController.view.frame = view.bounds
        view.addSubview(mainAppController.view)
        mainAppController.didMove(toParent: self)
    }
    
    //MARK: - Configure SwiftUI views
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
    
    //MARK: - Animate splashScreen
    func removeSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2){
            UIView.animate(withDuration: 0.3) {
                self.splashView.view.alpha = 0
                self.speratorBackGround.alpha = 0
            } completion: { finish in
                self.splashView.view.removeFromSuperview()
                self.speratorBackGround.removeFromSuperview()
            }
            
        }
    }
    
    // seperator in between splashScreen and userView to fix
    // the laggy transtion when splashScreen finished
    func insertSpertatorView() {
        view.addSubview(speratorBackGround)
        speratorBackGround.frame = view.bounds
        speratorBackGround.backgroundColor = .black
    }
    
    //MARK: - Declare Views
    let speratorBackGround = UIView()
    let splashView = UIHostingController(rootView: SplashScreenView())
    let userView = UIHostingController(rootView: LaunchView())
    let mainAppController = MainTabBarVC()
    
}

//MARK: - UserView Delegate
extension LaunchScreenVC: LaunchView.Delegate {
    func finishLoadingUser() {
        //
    }
}
