//
//  StaticNavBarView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 15/04/2024.
//

import SwiftUI

struct StaticNavBarView: View {
    var body: some View {
        Button("Edit", action: {})
            .bold()
            .font(.subheadline)
            .foregroundStyle(.white)
            .frame(width: 50)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .overlay {
                Text("Who's Watching?")
                    .bold()
                    .font(.title3)
                    .frame(maxWidth: .infinity)
            }
    }
}

#Preview {
    StaticNavBarView()
}
