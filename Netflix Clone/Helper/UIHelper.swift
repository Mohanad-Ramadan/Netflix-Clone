//
//  UIHelper.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 08/03/2024.
//

import SwiftUI
import UIKit

enum UIHelper {
    //MARK: - UIKit helper
    enum UIKit {
        // get LogoPath
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
        
        // get backdropPath
        static func getBackdropPathFrom(_ fetchedImages: MediaImage) -> String? {
            let sortedBackdrops = fetchedImages.backdrops.sorted(by: {$0.voteAverage > $1.voteAverage})
            if sortedBackdrops.isEmpty {
                return nil
            } else {
                return sortedBackdrops[0].filePath
            }
        }
        
        // filter fetched search results from persons
        static func removePersonsFrom(_ searchResults: [Media]) -> [Media] {
            let results = searchResults.filter { $0.mediaType == "movie" || $0.mediaType == "tv" }
            return results
        }
        
        // get the last tab image position
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
    
    //MARK: - SwiftUI helper
    enum SwiftUI {
        // animate a drawing path
        struct AnimateCardPath: ViewModifier, Animatable {
            var from: CGPoint
            var center: CGPoint
            var destination: CGPoint
            var animateFirstPortion: Bool
            var animateSecondPortion: Bool
            var path: Path
            var progress: CGFloat
            
            var animatableData: CGFloat {
                get {progress}
                set {progress = newValue}
            }
            
            func body(content: Content) -> some View {
                content
                    .position(
                        animateFirstPortion ?
                        (animateSecondPortion ? destination : center)
                        :
                        from
                    )
            }
            
        }
    }
}
