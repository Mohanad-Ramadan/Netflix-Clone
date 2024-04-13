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
                        .onTapGesture {
                            //
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

// UsersProfile
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

// AddButton
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

#Preview {
    UserSelectView()
}
