//
//  LaunchScreenView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 07/04/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct LaunchScreenView: View {
    var body: some View {
        AnimatedImage(url: url)
            .incrementalLoad(true)
            .resizable()
            .scaledToFit()
            .ignoresSafeArea()
    }
    
    private var url: URL{
        let bundelURL = Bundle.main.path(forResource: "NetflixGif", ofType: "gif")
        let url = URL(fileURLWithPath: bundelURL ?? "")
        return url
    }
}

#Preview {
    LaunchScreenView()
}
