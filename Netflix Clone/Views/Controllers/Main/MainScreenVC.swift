//
//  LaunchScreenVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/04/2024.
//

import UIKit
import SwiftUI

class MainScreenVC: UIViewController {
    
    // Declare Views
    let launchView = UIHostingController(rootView: LaunchView())
    let mainAppController = AppTabBarController()
    
    // loadView
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchView()
    }
    
    // Configure TabBarController
    func setupMainTabController() {
        addChild(mainAppController)
        mainAppController.view.frame = view.bounds
        view.insertSubview(mainAppController.view, belowSubview: launchView.view)
        mainAppController.didMove(toParent: self)
    }
    
    // Configure SwiftUI views
    func setupLaunchView() {
        addChild(launchView)
        launchView.view.frame = view.bounds
        launchView.view.backgroundColor = .clear
        view.addSubview(launchView.view)
        launchView.rootView.delegate = self
        launchView.didMove(toParent: self)
    }
}



//MARK: - UserView Delegate
extension MainScreenVC: LaunchView.Delegate {
    func getTabItemPosition() -> CGPoint {UIHelper.getMyNetflixTabItemFrame(from: mainAppController)}
    func addMainController() {setupMainTabController()}
    func endWithLaunchView() {self.launchView.view.removeFromSuperview()}
    
    func launchComplete() {
        if let tabItems = mainAppController.tabBar.items {
            tabItems[2].image = UIImage(resource: .profil).sd_resizedImage(with: CGSize(width: 25, height: 25), scaleMode: .aspectFit)?.withRenderingMode(.alwaysOriginal)
        }
        launchView.view.removeFromSuperview()
        launchView.removeFromParent()
    }
    
}


