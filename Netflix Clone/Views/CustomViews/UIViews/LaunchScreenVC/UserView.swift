//
//  UserView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/04/2024.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        VStack {
            HStack {
                UserBlock(user: "mohanad", resource: .profil)
                UserBlock(user: "Kids", resource: .kids)
            }
            AddProfile()
        }
        .padding(.bottom, 100)
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

#Preview {
    UserView()
}
