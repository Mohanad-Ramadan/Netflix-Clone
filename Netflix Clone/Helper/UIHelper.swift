//
//  UIHelper.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 08/03/2024.
//

import SwiftUI
import UIKit

enum UIHelper {
    
    //MARK: - Custom navigationBar
    static func customNavigatonBar() {
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    //MARK: - Other Helpers
    
    // filter fetched search results from persons
    static func removePersonsFrom(_ searchResults: [Media]) -> [Media] {
        let results = searchResults.filter { $0.mediaType == "movie" || $0.mediaType == "tv" }
        return results
    }
    
    // get the last tab image position
    static func getMyNetflixTabItemFrame(from mainTC: UITabBarController) -> CGPoint {
        // get home indicator frame for windowScene
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene, let window = windowScene.windows.first else {return .zero}
        let bottomInset = window.safeAreaInsets.bottom
        let topInset = window.safeAreaInsets.top
        
        // calculate the position
        let tabBar = mainTC.tabBar
        guard let mainVC = mainTC.viewControllers?[0], let tabItems = tabBar.items else {return .zero}
        // item midX point
        let itemHalfWidth = (tabBar.bounds.width / CGFloat(tabItems.count)) / 2
        let tabBarWidth = tabBar.bounds.width
        let imageXPoint = tabBarWidth - itemHalfWidth
        // item midY point
        guard let tabMidY = tabBar.frame(in: mainVC.view)?.midY else {return .zero}
        let tabBarMidY = tabMidY - (bottomInset+topInset)
        let imageYPoint = tabBarMidY - 5
        
        // check the current device
        if bottomInset != 0 {
            let imagePosition = CGPoint(x: imageXPoint , y: imageYPoint + 17)
            return imagePosition
        }
        let imagePosition = CGPoint(x: imageXPoint , y: imageYPoint)
        return imagePosition
    }
    
    
    // configure the childVC in a parentVC
    static func setupChildVC(from vc: UIViewController, in parent: UIViewController) {
        parent.addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        parent.view.addSubview(vc.view)
        vc.didMove(toParent: parent)
    }
    
}
