//
//  ProfileBlockAnchorKey.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/04/2024.
//

import SwiftUI

struct NFProfileKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue()) {$1}
    }
}
