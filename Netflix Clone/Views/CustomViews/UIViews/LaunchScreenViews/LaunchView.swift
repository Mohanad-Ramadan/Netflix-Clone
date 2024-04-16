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
     
    var body: some View {
        ZStack{
            UserProfilesView()
                .environment(launchData)
        }
        
    }
}

#Preview {
    LaunchView()
}
