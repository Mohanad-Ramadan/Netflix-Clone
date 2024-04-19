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
            Spacer()
        }
        .background(launchData.animateToTabBar ? .clear:.black)
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
            .anchorPreference(key: RectPositionKey.self,
                              value: .bounds,
                              transform: {
                anchor in [profile.sourceAnchorID: anchor]
            })
            .onTapGesture {
                launchData.profileSelected = profile
                launchData.animateProfile = true
                hideSelectView = true
                userTappedCallBack()
                animateCardToTabBar()
            }
            Text(profile.name).bold()
        }
    }
    
    //MARK: - AnimateToTabBar method
    
    // delay the animation after selected profile loads
    private func animateCardToTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {launchData.animateToTabBar = true; launchData.cardPathProgress = 1}
        }
    }
    
}


#Preview {
    UserProfilesView(userTappedCallBack: {})
        .environment(LaunchData())
}
