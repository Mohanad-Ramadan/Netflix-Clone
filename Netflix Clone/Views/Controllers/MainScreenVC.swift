//
//  LaunchScreenVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/04/2024.
//

import UIKit
import SwiftUI

class MainScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainTabController()
        setupUserView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeLaunchScreen()
    }
    
    //MARK: - Configure TabBarController
    func setupMainTabController() {
        addChild(mainAppController)
        mainAppController.view.frame = view.bounds
        view.addSubview(mainAppController.view)
        mainAppController.didMove(toParent: self)
    }
    
    //MARK: - Configure SwiftUI views
    func setupUserView() {
        addChild(userView)
        userView.view.frame = view.bounds
        view.addSubview(userView.view)
        userView.rootView.delegate = self
        userView.didMove(toParent: self)
    }
    
    //MARK: - Animate splashScreen
    func removeLaunchScreen() {
        //
    }
    
    //MARK: - Declare Views
    let userView = UIHostingController(rootView: LaunchView())
    let mainAppController = AppTabBarController()
    
}

//MARK: - UserView Delegate
extension MainScreenVC: LaunchView.Delegate {
    func finishLoadingUser() {
        //
    }
}
