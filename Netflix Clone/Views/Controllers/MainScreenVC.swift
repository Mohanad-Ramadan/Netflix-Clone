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
        setupLaunchView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        removeLaunchScreen()
    }
    
    //MARK: - Configure TabBarController
    func setupMainTabController() {
        addChild(mainAppController)
        mainAppController.view.frame = view.bounds
        view.insertSubview(mainAppController.view, belowSubview: launchView.view)
        mainAppController.didMove(toParent: self)
    }
    
    //MARK: - Configure SwiftUI views
    func setupLaunchView() {
        addChild(launchView)
        launchView.view.frame = view.bounds
        view.addSubview(launchView.view)
        launchView.rootView.delegate = self
        launchView.didMove(toParent: self)
        
    }
    
    //MARK: - Animate splashScreen
    func removeLaunchScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.launchView.view.removeFromSuperview()
        }
    }
    
    //MARK: - Declare Views
    let launchView = UIHostingController(rootView: LaunchView())
    let mainAppController = AppTabBarController()
    
}

//MARK: - UserView Delegate
extension MainScreenVC: LaunchView.Delegate {
    func addMainController() {setupMainTabController(); print("good morning")}
    
    func finishLoadingUser() {
        //
    }
}


