//
//  Trailer.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/01/2024.
//

import Foundation

// MARK: - Cast
struct Trailer: Codable {
    let results: [Reuslts]
    
    struct Reuslts: Codable{
        let name: String
        let key: String
        let site: String
        let type: String
    }
}
