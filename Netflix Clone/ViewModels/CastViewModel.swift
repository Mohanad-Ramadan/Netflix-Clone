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
    
    // return an array of all crew
    func createCrewArray() -> [String]{
        var crewArray = [String]()
        for member in cast.crew { crewArray.append(member.name); if crewArray.count == 5 {break} }
        return crewArray
    }
    
}
