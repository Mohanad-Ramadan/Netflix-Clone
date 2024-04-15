//
//  UserSelectView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 13/04/2024.
//

import SwiftUI

struct UserSelectView: View {
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
                    UserBlock(user: "mohanad", resource: .profil)
                        .scaleEffect(animateUserOne ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 + 0.2) {
                                withAnimation(.bouncy(duration: 0.7)) {
                                    animateUserOne = true
                                }
                            }
                        }
                    
                    UserBlock(user: "Kids", resource: .kids)
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
        Spacer()
    }
    
    //MARK: - UserProfile view
    @ViewBuilder
    func ProfileView(_ user: UserProfile) -> some View {
        VStack(spacing: 8) {
            GeometryReader { _ in
                Image(user.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(6)
                    .padding(.bottom, 5)
            }
            .frame(width: 100, height: 100)
            .anchorPreference(key: NFProfileKey.self, value: .bounds, transform: { anchor in
                [user.sourceAnchorID: anchor]
            })
            .onTapGesture {
                launchData.watchingProfle = user
                launchData.animateProfile = true
            }
            
            Text(user.name)
                .bold()
        }
    }
    
}

struct UserBlock: View {
    @Environment(LaunchData.self) private var laucnhData
    @State var user: String
    @State var resource: ImageResource
    @State var profileTapped = false
    
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { _ in
                Image(resource)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(6)
                    .padding(.bottom, 5)
            }
            .frame(width: 100, height: 100)
            .onTapGesture {
                profileTapped = true
            }
            
            Text(user)
                .bold()
        }
    }
}


struct SelectedProfileView: View {
    @State var animateView = false
    
    let finishSize = UIScreen.main.bounds.width/2
    let screenCenter = CGPoint(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/4)
    
    var body: some View {
        VStack {
            Image(.profil)
                .resizable()
                .cornerRadius(6)
                .frame(width: animateView ? finishSize : 100, height: animateView ? finishSize : 100)
                .padding(animateView ? 70 : 0)
            
        }
        .onAppear {withAnimation {animateView = true}}
        
    }
}


#Preview {
    UserSelectView()
        .environment(LaunchData())
}
