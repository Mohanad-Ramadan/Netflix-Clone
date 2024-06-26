//
//  AppTabBarController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import UIKit

class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: NewHotVC())
        let vc3 = UINavigationController(rootViewController: MyNetflixVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc1.title = "Home"
        
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc2.title = "New & Hot"
        
        vc3.tabBarItem.image = UIImage().sd_resizedImage(with: CGSize(width: 25, height: 25), scaleMode: .aspectFit)?.withRenderingMode(.alwaysOriginal)
        vc3.title = "My Netflix"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3], animated: true)
    }
    
    
}

