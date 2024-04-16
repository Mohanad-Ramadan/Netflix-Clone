//
//  UserProfilesView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 13/04/2024.
//

import SwiftUI

struct UserProfilesView: View {
    // Environment variables
    @Environment(LaunchData.self) private var launchData
    // animation variables
    @State private var animateUserOne = false
    @State private var animateUserTwo = false
    @State private var animateAddProfile = false
    @State private var hideProfiles = false
    //ConstantValue
    let virticalSpacing = UIScreen.main.bounds.height * 0.2
    
    var body: some View {
        VStack(spacing: virticalSpacing) {
            StaticNavBarView().frame(alignment: .top)
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
            .opacity(hideProfiles ? 0:1)
        }
        .overlayPreferenceValue(NFProfileKey.self) { value in
            SelectedCardView(value)
        }
        Spacer()
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
            .anchorPreference(key: NFProfileKey.self, value: .bounds, transform:
                                { anchor in [profile.sourceAnchorID: anchor] })
            .onTapGesture {
                launchData.profileSelected = profile
                launchData.animateProfile = true
                hideProfiles = true
            }
            Text(profile.name).bold()
        }
    }
    
    //MARK: - SelectedCard View
    @State private var animateSelectedCard = false
    let cardEndSize = UIScreen.main.bounds.width/2
    let spinnerOffest = UIScreen.main.bounds.height*0.08
    
    @ViewBuilder
    func SelectedCardView(_ value: [String: Anchor<CGRect>]) -> some View {
        GeometryReader { geo in
            // Safely unwrap the selected profile
            if let profile = launchData.profileSelected, let sourceAnchorID = value[profile.sourceAnchorID], launchData.animateProfile {
                // Decalre selected profile variables
                let cardGeo = geo[sourceAnchorID]
                let screenGeo = geo.frame(in: .global)
                let cardPosition = CGPoint(x: cardGeo.midX, y: cardGeo.midY)
                let endPosition = CGPoint(x: screenGeo.midX, y: screenGeo.midY)
                // Decalre View
                VStack {
                    Image(profile.image)
                        .resizable()
                        .cornerRadius(6)
                        .frame(width: animateSelectedCard ? cardEndSize : 100, height: animateSelectedCard ? cardEndSize : 100)
                        .padding(animateSelectedCard ? 70 : 0)
                        .position(animateSelectedCard ? endPosition : cardPosition)
                        .onAppear {
                            withAnimation(.bouncy(extraBounce: 0.1).speed(1.5)) {animateSelectedCard = true}
                        }
                    NFLoadingSpinnerView()
                        .offset(y: spinnerOffest)
                        .opacity(animateSelectedCard ? 1 : 0)
                }
                
            }
        }
    }
    
}


#Preview {
    UserProfilesView()
        .environment(LaunchData())
}
