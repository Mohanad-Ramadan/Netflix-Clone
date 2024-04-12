//
//  UserView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/04/2024.
//

import SwiftUI

struct UserView: View {
    protocol Delegate: AnyObject {func buttonDidTapped()}
    weak var delegate: Delegate!
    
    @State private var mohanadAnimationStarted = false
    @State private var kidsAnimationStarted = false
    @State private var addProfileAnimationStarted = false
    
    var body: some View {
        VStack {
            StaticNavBar()
                .frame(alignment: .top)
            Spacer()
            VStack {
                HStack(spacing: 20) {
                    UserBlock(user: "mohanad", resource: .profil)
                        .scaleEffect(mohanadAnimationStarted ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.bouncy(duration: 0.8)) {
                                    mohanadAnimationStarted = true
                                }
                            }
                        }
                    
                    UserBlock(user: "Kids", resource: .kids)
                        .scaleEffect(kidsAnimationStarted ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.bouncy(duration: 0.8)) {
                                    kidsAnimationStarted = true
                                }
                            }
                        }
                }
                
                AddProfile()
                    .scaleEffect(addProfileAnimationStarted ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            withAnimation(.bouncy(duration: 0.8)) {
                                addProfileAnimationStarted = true
                            }
                        }
                    }
            }
            Spacer()
            Spacer()
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


struct UserBlock: View {
    @State var user: String
    @State var resource: ImageResource
    
    var body: some View {
        VStack {
            Image(resource)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(6)
                .padding(.bottom, 5)
            Text(user)
                .bold()
        }
        .padding(8)
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


#Preview { UserView() }
