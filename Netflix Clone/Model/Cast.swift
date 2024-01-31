//
//  Cast.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/01/2024.
//

import Foundation

// MARK: - Cast
struct Cast: Codable, CastSeparatable, ReturnDirector{
    let cast: [Actors]
    let crew: [Crew]
    
    struct Actors: Codable {
        let name: String
    }
    
    struct Crew: Codable {
        let name: String
        let job: String
    }
    
    func returnDirector() -> String {
        let directors = crew.filter { $0.job == "Director" }
        return "Director: " + directors[0].name
    }
    
    func returnThreeCastSeperated(with: String) -> String {
        let castNames = cast.prefix(3)
        let threeCast = castNames.map { $0.name }
        return "Cast: " + threeCast.joined(separator: with)
    }
}

//MARK: - Protocols

protocol CastSeparatable {
    func returnThreeCastSeperated(with: String) -> String
}

protocol ReturnDirector {
    func returnDirector() -> String
}
