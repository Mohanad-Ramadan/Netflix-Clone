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
        let creator = crew.filter {$0.job == "Executive Producer"}
        let writer = crew.filter {$0.job == "Novel" || $0.job == "Book"}
        
        if !directors.isEmpty {
            return "Director: " + directors[0].name
        } else if !creator.isEmpty, let secondCreator = creator[safe: 1] {
            return "Creator: \(creator[0].name), \(secondCreator.name)"
        } else {
            return "Creator: " + writer[0].name
        }
    }
    
    func returnThreeCastSeperated(with: String) -> String {
        let names = cast.map { $0.name }
        return "Cast: " + names.joined(separator: with)
    }
}

//MARK: - Protocols

protocol CastSeparatable {
    func returnThreeCastSeperated(with: String) -> String
}

protocol ReturnDirector {
    func returnDirector() -> String
}
