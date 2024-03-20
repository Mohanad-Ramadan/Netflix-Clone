//
//  Collection.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
