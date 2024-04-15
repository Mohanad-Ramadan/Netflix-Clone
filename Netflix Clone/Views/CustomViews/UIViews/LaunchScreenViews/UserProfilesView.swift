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
    @State private var animateToCenter = false
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
            .anchorPreference(key: NFProfileKey.self, value: .bounds, transform: { anchor in
                [profile.sourceAnchorID: anchor]
            })
            .onTapGesture {
                launchData.profileSelected = profile
                launchData.animateProfile = true
            }
            
            Text(profile.name)
                .bold()
        }
    }
    
    //MARK: - SelectedCard View
    @State private var animateSelectedCard = false
    let cardEndSize = UIScreen.main.bounds.width/2
    
    @ViewBuilder
    func SelectedCardView(_ value: [String: Anchor<CGRect>]) -> some View {
        GeometryReader { geo in
            if let profile = launchData.profileSelected, let sourceAnchorID = value[profile.sourceAnchorID], launchData.animateProfile {
                // Decalre selected profile variables
                let cardGeo = geo[sourceAnchorID]
                let cardPosition = CGPoint(x: cardGeo.midX, y: cardGeo.midY)
                // Decalre View
                Image(.profil)
                    .resizable()
                    .cornerRadius(6)
                    .frame(width: animateSelectedCard ? cardEndSize : 100, height: animateSelectedCard ? cardEndSize : 100)
                    .padding(animateSelectedCard ? 70 : 0)
                    .position(cardPosition)
                    .onAppear {
                        withAnimation {animateSelectedCard = true}
                    }
            }
            
        }
    }
    
}

//struct SelectedProfileView: View {
//    @State var animateView = false
//
//    let finishSize = UIScreen.main.bounds.width/2
//    let screenCenter = CGPoint(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/4)
//
//    var body: some View {
//        VStack {
//            Image(.profil)
//                .resizable()
//                .cornerRadius(6)
//                .frame(width: animateView ? finishSize : 100, height: animateView ? finishSize : 100)
//                .padding(animateView ? 70 : 0)
//
//        }
//        .onAppear {withAnimation {animateView = true}}
//
//    }
//}


#Preview {
    UserProfilesView()
        .environment(LaunchData())
}
