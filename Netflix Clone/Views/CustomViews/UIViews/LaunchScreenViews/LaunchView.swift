//
//  LaunchView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/04/2024.
//

import SwiftUI

struct LaunchView: View {
    // Delegate protocol
    protocol Delegate: AnyObject {
        func endWithLaunchView()
        func addMainController()
        func getTabItemPosition() -> CGPoint
    }
    weak var delegate: Delegate!
    // Declare View properties
    @State private var launchData = LaunchData()
    @State private var splashScreenOn = true
    
    
    var body: some View {
        ZStack{
            UserProfilesView(userTappedCallBack: startAddingMainScreen, selectedCardEndPoint: delegate.getTabItemPosition)
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
    
    private func startAddingMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {delegate.addMainController()}
    }
}

//#Preview {
//    LaunchView()
//}
