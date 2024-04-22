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
            
            // get home indicator frame for windowScene
            let scenes = UIApplication.shared.connectedScenes
            guard let windowScene = scenes.first as? UIWindowScene, let window = windowScene.windows.first else {return .zero}
            let bottomInset = window.safeAreaInsets.bottom
            let topInset = window.safeAreaInsets.top
            
            // calculate the position
            let tabBar = mainTC.tabBar
            let mainVC = mainTC.viewControllers![0]
            // item midX point
            let itemHalfWidth = (tabBar.bounds.width / CGFloat(tabBar.items!.count)) / 2
            let tabBarWidth = tabBar.bounds.width
            let imageXPoint = tabBarWidth - itemHalfWidth
            // item midY point
            let tabBarMidY = tabBar.frame(in: mainVC.view)!.midY - (bottomInset+topInset)
            let imageYPoint = tabBarMidY - 5
            
            // check the current device
            if bottomInset != 0 {
                let imagePosition = CGPoint(x: imageXPoint , y: imageYPoint + 17)
                return imagePosition
            }
            let imagePosition = CGPoint(x: imageXPoint , y: imageYPoint)
            return imagePosition
        }
    }
    
    
    //MARK: - SwiftUI helper
    enum SwiftUI {
        // animate a drawing path
        struct AnimateCardPath: ViewModifier, Animatable {
            init(from startPoint: CGPoint, center: CGPoint, to destination: CGPoint, animateFirstPortion: Bool, animateSecondPortion: Bool, path: Path, pathProgress: CGFloat) {
                beginPoint = startPoint
                centerPoint = center
                endPoint = destination
                progress = pathProgress
                self.animateFirstPortion = animateFirstPortion
                self.animateSecondPortion = animateSecondPortion
                self.path = path
            }
            
            var beginPoint: CGPoint
            var centerPoint: CGPoint
            var endPoint: CGPoint
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
                        (animateSecondPortion ? (path.trimmedPath(from: 0, to: progress).currentPoint) ?? beginPoint : centerPoint)
                        :
                        beginPoint
                    )
            }
            
        }
    }
}
