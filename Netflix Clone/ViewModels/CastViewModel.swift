//
//  CastViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 26/04/2024.
//

import Foundation

struct CastViewModel {
    init(_ cast: Cast) { self.cast = cast }
    
    let cast: Cast
    
    // return an array of all actors
    func createActorsArray() -> [String]{
        var actorsArray = [String]()
        for actor in cast.cast { actorsArray.append(actor.name); if actorsArray.count == 15 {break} }
        return actorsArray
    }
    
    // return an array of creators
    func createCreatorArray() -> [String]{
        var creatorArray = [String]()
        for member in cast.crew.enumerated() {
                // return director If it's there
            if cast.crew.contains(where: { $0.job == "Directing" }) {
                if member.element.job == "Directing" { creatorArray.append(member.element.name) }
                print("there is director")
                // return Executive Producer
            } else {
                if member.element.job == "Executive Producer" { creatorArray.append(member.element.name) }
            }
            
            if creatorArray.count == 3 {break}
        }
        return creatorArray
    }
    
    func createWritersArray() -> [String] {
        var writersArray = [String]()
        for writer in cast.crew.enumerated() {
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
    
}
