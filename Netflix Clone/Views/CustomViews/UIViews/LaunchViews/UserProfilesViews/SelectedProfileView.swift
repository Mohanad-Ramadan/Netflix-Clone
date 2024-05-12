//
//  SelectedProfileView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/04/2024.
//

import SwiftUI

struct SelectedProfileView: View {
    @Environment(LaunchData.self) var launchData
    @State var value: [String: Anchor<CGRect>]
    // Constant
    let cardEndSize = UIScreen.main.bounds.width/2.3
    let pathControlPoint = CGPoint(
        x: UIScreen.main.bounds.width,
        y: -UIScreen.main.bounds.height * 0.4
    )
    let cardEndPosition: () -> CGPoint
    
    // View
    var body: some View {
        GeometryReader { geo in
            
            // Safely unwrap the selected profile
            if let profile = launchData.profileSelected, let sourceAnchorID = value[profile.sourceAnchorID], launchData.animateProfile {
                
                // Decalre selected profile constants
                let cardGeo = geo[sourceAnchorID]
                let screenGeo = geo.frame(in: .global)
                let startPosition = CGPoint(x: cardGeo.midX, y: cardGeo.midY)
                let screenCenter = CGPoint(x: screenGeo.width/2, y: screenGeo.height/2.5)
                let imageTabScale = (25/cardEndSize)
                
                // Path animation to tabBar
                let tabBarItemPath = Path { path in
                    path.move(to: screenCenter)
                    path.addQuadCurve(
                        to: cardEndPosition(),
                        control: pathControlPoint
                    )
                }
                
                // Layout the Subviews
                ZStack {
                    Image(profile.image)
                        .resizable()
                        .cornerRadius(launchData.animateToTabBar ? 2:6)
                        .frame(
                            width: launchData.animateToCenter ? cardEndSize : 100,
                            height: launchData.animateToCenter ? cardEndSize : 100
                        )
                        .scaleEffect(
                            CGSize(
                                width: launchData.animateToTabBar ? imageTabScale : 1,
                                height: launchData.animateToTabBar ? imageTabScale : 1
                            )
                        )
                        .modifier(
                            AnimateCardPath(
                                from: startPosition,
                                center: screenCenter,
                                to: cardEndPosition(),
                                animateFirstPortion: launchData.animateToCenter,
                                animateSecondPortion: launchData.animateToTabBar,
                                path: tabBarItemPath,
                                pathProgress: launchData.cardPathProgress
                            )
                        )
                        .animation(.bouncy(extraBounce: 0.1).speed(1.5), value: launchData.animateToCenter)
                        .animation(.linear.speed(2), value: launchData.animateToTabBar)
                        .onAppear {launchData.animateToCenter = true}
                    
                    LoadingSpinnerView()
                        .offset(y: 100)
                        .opacity(launchData.animateToCenter ? 1 : 0)
                        .opacity(launchData.animateToTabBar ? 0 : 1)
                        .animation(.linear.speed(2), value: launchData.animateToCenter)
                        .animation(.linear.speed(2), value: launchData.animateToTabBar)
                }
                
            }
        }
    }

}


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
