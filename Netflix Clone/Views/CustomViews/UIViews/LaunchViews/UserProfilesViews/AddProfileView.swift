//
//  AddProfileView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 15/04/2024.
//

import SwiftUI

struct AddProfileView: View {
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
    AddProfileView()
}
