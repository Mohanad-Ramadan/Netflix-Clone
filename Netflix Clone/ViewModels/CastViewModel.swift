//
//  CastViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 26/04/2024.
//

import Foundation

struct CastViewModel {
    
    private let allCast: Cast
    
    init(_ cast: Cast) { self.allCast = cast }
    
    
    var directors: String {
        let directors = allCast.crew.filter { $0.job == "Director" }
        let creator = allCast.crew.filter {$0.job == "Executive Producer"}
        let writer = allCast.crew.filter {$0.job == "Novel" || $0.job == "Book" || $0.job == "Original Concept"}
        
        if !directors.isEmpty {
            return "Director: " + directors[0].name
        } else if !creator.isEmpty, let secondCreator = creator[safe: 1] {
            return "Creator: \(creator[0].name), \(secondCreator.name)"
        } else {
            if let writer = writer[safe:0] { return "Creator: " + writer.name }
            return "Crew: " + allCast.crew[0].name
        }
    }
    
    
    var actorsArray: [String]{
        var actorsArray = [String]()
        for actor in allCast.cast { actorsArray.append(actor.name); if actorsArray.count == 15 {break} }
        return actorsArray
    }
    
    var creatorArray: [String] {
        var creatorArray = [String]()
        for member in allCast.crew.enumerated() {
                // return director If it's there
            if allCast.crew.contains(where: { $0.job == "Directing" }) {
                if member.element.job == "Directing" { creatorArray.append(member.element.name) }
                // return Executive Producer
            } else {
                if member.element.job == "Executive Producer" { creatorArray.append(member.element.name) }
            }
            if creatorArray.count == 3 {break}
        }
        return creatorArray
    }
    
    
    var writersArray: [String] {
        var writersArray = [String]()
        for writer in allCast.crew.enumerated() {
            if writer.element.job == "Writer" ||
                writer.element.job == "Novel" ||
                writer.element.job == "Book" ||
                writer.element.job == "Original Concept"
            {
                writersArray.append(writer.element.name)
            }
            if writersArray.count == 3 {break}
        }
        return writersArray
    }
    
    
    // return three actors for details
    func getSomeActros(totalActors: Int ,seperator with: String) -> String {
        let someActors = Array(allCast.cast.prefix(totalActors))
        let names = someActors.map{$0.name}
        return "Cast: " + names.joined(separator: with)
    }
    
}
