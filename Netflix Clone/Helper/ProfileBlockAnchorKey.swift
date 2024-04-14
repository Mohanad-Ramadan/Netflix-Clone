//
//  ProfileBlockAnchorKey.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/04/2024.
//

import SwiftUI

struct ProfileBlockAnchorKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
    
}

