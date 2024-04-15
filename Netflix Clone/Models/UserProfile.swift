//
//  UserProfile.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 16/04/2024.
//

import SwiftUI

struct UserProfile: Identifiable {
    var id: UUID = .init()
    var name: String
    var image: ImageResource
    
    var sourceAnchorID: String {id.uuidString + "SOURCE"}
    
    var destinationAnchoreID: String {id.uuidString + "SOURCE"}
}

var mockProfiles: [UserProfile] = [
    .init(name: "mohanad", image: .profil),
    .init(name: "Kids", image: .kids)
]
