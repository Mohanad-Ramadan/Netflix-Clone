//
//  UIHelper.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 08/03/2024.
//

import Foundation
import UIKit

enum UIHelper {
    
    // MARK: get LogoPath
    static func getLogoDetailsFrom(_ fetchedImages: MediaImage) -> (String,Double)? {
        let logos = fetchedImages.logos
        
        if logos.isEmpty {
            return nil
        } else if let englishLogo = logos.first(where: { $0.iso6391 == "en" }) {
            return (englishLogo.filePath, englishLogo.aspectRatio)
        } else {
            return (logos[0].filePath, logos[0].aspectRatio)
        }
    }
    
    // MARK: - get backdropPath
    static func getBackdropPathFrom(_ fetchedImages: MediaImage) -> String? {
        let sortedBackdrops = fetchedImages.backdrops.sorted(by: {$0.voteAverage > $1.voteAverage})
        if sortedBackdrops.isEmpty {
            return nil
        } else {
            return sortedBackdrops[0].filePath
        }
    }
    
    //MARK: - filter fetched search results from persons
    static func removePersonsFrom(_ searchResults: [Media]) -> [Media] {
        let results = searchResults.filter { $0.mediaType == "movie" || $0.mediaType == "tv" }
        return results
    }
    
    //MARK: - get the last tab image position
    static func getMyNetflixTabFrame(from mainTC: UITabBarController) -> CGPoint {
        let tabBar = mainTC.tabBar
        let mainVC = mainTC.viewControllers![0]
        // item midX point
        let itemHalfWidth = (tabBar.bounds.width / CGFloat(tabBar.items!.count)) / 2
        let tabBarWidth = tabBar.bounds.width
        let itemMidX = tabBarWidth - itemHalfWidth
        // item midY point
        let tabBarHeight = tabBar.frame(in: mainVC.view)!.minY
        let imageMidY = tabBarHeight - (tabBar.items![2].image!.size.width/2)
        
        let imagePosition = CGPoint(x: itemMidX , y: imageMidY + 1)
        return imagePosition
    }
}
