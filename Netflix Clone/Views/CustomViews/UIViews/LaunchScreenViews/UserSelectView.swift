//
//  UserSelectView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 13/04/2024.
//

import SwiftUI

struct UserSelectView: View {
    @State private var animateUserOne = false
    @State private var animateUserTwo = false
    @State private var animateAddProfile = false
    
    var body: some View {
        VStack {
            StaticNavBar()
                .frame(alignment: .top)
            Spacer()
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
                
                AddProfile()
                    .scaleEffect(animateAddProfile ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 + 0.6) {
                            withAnimation(.bouncy(duration: 0.7)) {
                                animateAddProfile = true
                            }
                        }
                    }
            }
            Spacer()
            Spacer()
        }
    }
}


struct UserBlock: View {
    @State var user: String
    @State var resource: ImageResource
    @State var profileTapped = false
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let position = geo.frame(in: .global)
                Image(resource)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(6)
                    .padding(.bottom, 5)
                    .preference(key: ProfileBlockAnchorKey.self, value: position.origin)
            }
            .frame(width: 100, height: 100)
            .overlayPreferenceValue (ProfileBlockAnchorKey.self) { newValue in
                if profileTapped { SelectedProfileView(startPosition: newValue) }
            }
            .onTapGesture {profileTapped = true}
            
            Text(user)
                .bold()
        }
        .padding(8)
    }
}


struct SelectedProfileView: View {
    @State var startPosition: CGPoint
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


struct LoadingSpinner: View {
    @State var isAnimating = false
    let redAccent = Color(.red.darker)
    
    var body: some View {
        Circle()
            .stroke(.linearGradient(colors: [
                redAccent,
                redAccent,
                redAccent,
                redAccent,
                redAccent.opacity(0.9),
                redAccent.opacity(0.8),
                redAccent.opacity(0.7),
                redAccent.opacity(0.5),
                redAccent.opacity(0.4),
                redAccent.opacity(0.1),
                .clear,
                .clear
            ], startPoint: .top, endPoint: .bottom), lineWidth: 10)
            .rotationEffect(.init(degrees: isAnimating ? 360 : 0))
            .frame(width: 100, height: 100)
            .onAppear{
                withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: false)) { isAnimating = true }
            }
            
    }
}


struct AddProfile: View {
    var body: some View {
        VStack {
            ZStack {
                Image(.addProfile)
                    .resizable()
                    .frame(width: 100,height: 100)
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(.lightGray), lineWidth: 1)
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 5)
                    .padding(.top, 5)
            }
            Text("Add Profile")
                .bold()
        }
    }
}


struct StaticNavBar: View {
    var body: some View {
        ZStack {
            Text("Who's Watching?")
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity)
            Button("Edit", action: {})
                .bold()
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(width: 50)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    UserSelectView()
}
