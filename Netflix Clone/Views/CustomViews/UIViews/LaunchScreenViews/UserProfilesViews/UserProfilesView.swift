//
//  UserProfilesView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 13/04/2024.
//

import SwiftUI

struct UserProfilesView: View {
    // CallBack method to ParentView
    let userTappedCallBack: () -> Void
    // Environment variables
    @Environment(LaunchData.self) private var launchData
    // animation variables
    @State private var animateUserOne = false
    @State private var animateUserTwo = false
    @State private var animateAddProfile = false
    @State private var hideSelectView = false
    @State private var animateToTabBar = false
    // Constant Value
    let virticalSpacing = UIScreen.main.bounds.height * 0.2
    
    var body: some View {
        VStack {
            StaticNavBarView()
                .padding(.bottom, virticalSpacing)
                .opacity(hideSelectView ? 0:1)
            VStack {
                HStack(spacing: 20) {
                    ProfileCardView(mockProfiles[0])
                        .scaleEffect(animateUserOne ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 + 0.2) {
                                withAnimation(.bouncy(duration: 0.7)) {
                                    animateUserOne = true
                                }
                            }
                        }
                    
                    ProfileCardView(mockProfiles[1])
                        .scaleEffect(animateUserTwo ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 + 0.4) {
                                withAnimation(.bouncy(duration: 0.7)) {
                                    animateUserTwo = true
                                }
                            }
                        }
                }
                AddProfileView()
                    .scaleEffect(animateAddProfile ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 + 0.6) {
                            withAnimation(.bouncy(duration: 0.7)) {
                                animateAddProfile = true
                            }
                        }
                    }
            }
            .opacity(hideSelectView ? 0:1)
            .overlayPreferenceValue(RectPositionKey.self) { value in
                SelectedCardView(value)
            }
            Spacer()
        }
        .background(animateToTabBar ? .clear:.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    //MARK: - UserProfile View
    @ViewBuilder
    func ProfileCardView(_ profile: UserProfile) -> some View {
        VStack(spacing: 8) {
            GeometryReader { _ in
                Image(profile.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(6)
                    .padding(.bottom, 5)
            }
            .frame(width: 100, height: 100)
            .anchorPreference(key: RectPositionKey.self, value: .bounds, transform:
                                { anchor in [profile.sourceAnchorID: anchor] })
            .onTapGesture {
                launchData.profileSelected = profile
                launchData.animateProfile = true
                hideSelectView = true
                userTappedCallBack()
                clearViewBackground()
            }
            Text(profile.name).bold()
        }
    }
    
    private func clearViewBackground() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {animateToTabBar = true}
        }
    }
    
    //MARK: - SelectedCard View
    @State private var animateToCenter = false
    let cardEndSize = UIScreen.main.bounds.width/2.3
    let spinnerOffest = UIScreen.main.bounds.height*0.08
    let cardEndPosition: () -> CGPoint
    
    // View method
    @ViewBuilder
    func SelectedCardView(_ value: [String: Anchor<CGRect>]) -> some View {
        GeometryReader { geo in
            // Safely unwrap the selected profile
            if let profile = launchData.profileSelected, let sourceAnchorID = value[profile.sourceAnchorID], launchData.animateProfile {
                // Decalre selected profile constants
                let cardGeo = geo[sourceAnchorID]
                let screenGeo = geo.frame(in: .global)
                let startPosition = CGPoint(x: cardGeo.midX, y: cardGeo.midY)
                let screenCenter = CGPoint(x: screenGeo.width/2, y: screenGeo.height/3)
                let imageTabScale = (25/cardEndSize)
                // Path animation to tabBar
                let tabBarItemPath = Path { path in
                    path.move(to: screenCenter)
                    path.addLine(to: cardEndPosition())
                }
                
                tabBarItemPath.stroke(lineWidth: 1)
                
                // Decalre View
                VStack {
                    Image(profile.image)
                        .resizable()
                        .cornerRadius(animateToTabBar ? 2:6)
                        .frame(
                            width: animateToCenter ? cardEndSize : 100,
                            height: animateToCenter ? cardEndSize : 100
                        )
                        .scaleEffect(
                            CGSize(
                                width: animateToTabBar ? imageTabScale : 1,
                                height: animateToTabBar ? imageTabScale : 1
                            )
                        )
                        .padding(animateToCenter ? 70 : 0)
                        .position(
                            animateToCenter ? 
                            (animateToTabBar ? cardEndPosition() : screenCenter)
                            :
                            startPosition
                        )
                        .animation(.bouncy(extraBounce: 0.1).speed(1.5), value: animateToCenter)
                        .animation(.linear.speed(2), value: animateToTabBar)
                        .onAppear {animateToCenter = true}
                    
                    LoadingSpinnerView()
                        .offset(y: spinnerOffest)
                        .opacity(animateToCenter ? 1 : 0)
                        .opacity(animateToTabBar ? 0 : 1)
                        .animation(.linear.speed(2), value: animateToCenter)
                        .animation(.linear.speed(2), value: animateToTabBar)
                }
                
            }
        }
    }
    
}

//MARK: - AnimateCardPath
struct AnimateCardPath: ViewModifier, Animatable {
    let source: CGPoint
    let center: CGPoint
    let destination: CGPoint
    var animateToCenter: Bool
    var animateToTabBar: Bool
    var path: Path
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get {progress}
        set {progress = newValue}
    }
    
    func body(content: Content) -> some View {
        content
            .position()
    }
    
}


#Preview {
    UserProfilesView(userTappedCallBack: {}, cardEndPosition: staticPreview)
        .environment(LaunchData())
}

func staticPreview() -> CGPoint {CGPoint(x: 240, y: 550)}
