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
        launchView.view.backgroundColor = .clear
        view.addSubview(launchView.view)
        launchView.rootView.delegate = self
        launchView.didMove(toParent: self)
    }
    
    //MARK: - Declare Views
    let launchView = UIHostingController(rootView: LaunchView())
    let mainAppController = AppTabBarController()
    
}

//MARK: - UserView Delegate
extension MainScreenVC: LaunchView.Delegate {
    func getTabItemPosition() -> CGPoint {UIHelper.getMyNetflixTabFrame(from: mainAppController)}
    
    func addMainController() {setupMainTabController(); print("good morning")}
    
    func endWithLaunchView() {self.launchView.view.removeFromSuperview()}
}


