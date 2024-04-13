//
//  LoadingProfileView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/04/2024.
//

import SwiftUI

struct LoadingProfileView: View {
    var body: some View {
        VStack {
            Image(.profil)
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                .cornerRadius(6)
                .padding(.bottom, 70)
            LoadingSpinner()
                .frame(width: 100, height: 100)
        }
    }
}

// LoadingSpinner
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
//            .onAppear{
//                withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: false)) { isAnimating = true }
//            }
            
    }
}

#Preview {
    LoadingProfileView()
}
