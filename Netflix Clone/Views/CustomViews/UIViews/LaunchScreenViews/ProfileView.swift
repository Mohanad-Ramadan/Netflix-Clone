//
//  ProfileView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/04/2024.
//

import SwiftUI

struct ProfileView: View {
    protocol Delegate: AnyObject {func finishLoadingUser()}
    weak var delegate: Delegate!
    
    var body: some View {
        UserSelectView()
        
    }
}

#Preview {
    ProfileView()
}
