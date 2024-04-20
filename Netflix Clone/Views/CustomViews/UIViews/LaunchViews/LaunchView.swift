//
//  LaunchView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/04/2024.
//

import SwiftUI

struct LaunchView: View {
    // Declare delegate instance
    weak var delegate: Delegate!
    
    // Declare View properties
    @State private var launchData = LaunchData()
    @State private var splashScreenOn = true
    
    
    var body: some View {
        ZStack{
            UserProfilesView(userTappedCallBack: startAddingMainScreen)
                .padding(.horizontal, 5)
                .overlayPreferenceValue(RectPositionKey.self) { value in
                    SelectedProfileView(value: value, cardEndPosition: delegate.getTabItemPosition)
                }
            SplashScreenView()
                .opacity(splashScreenOn ? 1:0)
                .animation(.easeIn, value: splashScreenOn)
                .onAppear(perform: removeSplashScreen)
        }
        .environment(launchData)
        .onChange(of: launchData.launchFinishs) { _, done in
            guard done else {return}
            delegate.launchComplete()
        }
    }
    
    
    private func removeSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {splashScreenOn = false}
    }
    
    private func startAddingMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {delegate.addMainController()}
    }
}


//MARK: - Delegate protocol
extension LaunchView{
    protocol Delegate: AnyObject {
        func endWithLaunchView()
        func addMainController()
        func getTabItemPosition() -> CGPoint
        func launchComplete()
    }
}
