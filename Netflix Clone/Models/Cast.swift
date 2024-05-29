//
//  Cast.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/01/2024.
//

import Foundation

// MARK: - Cast
struct Cast: Codable{
    let cast: [Actors]
    let crew: [Crew]
    
    struct Actors: Codable {
        let name: String
    }
    
    struct Crew: Codable {
        let name, job , department : String
    }
}
