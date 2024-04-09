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
        setupSplashView()
        
    }
    
    func setupSplashView() {
        addChild(splashViewlet)
        splashViewlet.view.frame = view.bounds
        view.addSubview(splashViewlet.view)
        splashViewlet.didMove(toParent: self)
    }
    
    func setupUserView() {
        addChild(userView)
        userView.view.frame = view.bounds
        view.addSubview(userView.view)
        userView.didMove(toParent: self)
    }
    
    
    let splashViewlet = UIHostingController(rootView: LaunchScreenView())
    let userView = UIHostingController(rootView: UserView())
}
