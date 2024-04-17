//
//  LaunchView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/04/2024.
//

import SwiftUI

struct LaunchView: View {
    // Bridge View with LaunchVC with delegate
    protocol Delegate: AnyObject {func finishLoadingUser()}
    weak var delegate: Delegate!
    // Declare View properties
    @State private var launchData = LaunchData()
    @State private var splashScreenOn = true
    
    
    var body: some View {
        ZStack{
            UserProfilesView()
                .environment(launchData)
                .padding(.horizontal, 5)
            SplashScreenView()
                .opacity(splashScreenOn ? 1:0)
                .animation(.easeIn, value: splashScreenOn)
                .onAppear(perform: removeSplashScreen)
        }
        
    }
    
    
    private func removeSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {splashScreenOn = false}
    }
    
}

#Preview {
    LaunchView()
}
