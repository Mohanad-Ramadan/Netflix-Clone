//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: NewAndHotVC())
        let vc3 = UINavigationController(rootViewController: MyNetflixVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc1.title = "Home"
        
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc2.title = "New & Hot"
        
        vc3.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        vc3.title = "My Netflix"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3], animated: true)
    }


}

