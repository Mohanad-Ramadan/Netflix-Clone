//
//  LaunchScreenData.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 15/04/2024.
//

import SwiftUI
import Observation

@Observable
class LaunchData {
    var profileSelected: UserProfile?
    var animateProfile: Bool = false
    var showProfileView: Bool = false 
}
