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
        let vc3 = UINavigationController(rootViewController: DownloadVC())
//        let vc4 = UINavigationController(rootViewController: FastLaughsVC())
//        let vc5 = UINavigationController(rootViewController: SearchVC())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc1.title = "Home"
        
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc2.title = "New & Hot"
        
//        vc4.tabBarItem.image = UIImage(systemName: "face.smiling")
//        vc4.title = "Fast Laughs"
        
        vc3.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        vc3.title = "Downloads"
        
//        vc5.tabBarItem.image = UIImage(systemName: "magnifyingglass")
//        vc5.title = "Search"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3], animated: true)
    }


}

