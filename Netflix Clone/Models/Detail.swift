//
//  EntertainmentDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation

// MARK: - Detial
struct MovieDetail : Codable, GenreSeparatable{
    let title: String
    let id: Int
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    let runtime: Int
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    func separateGenres(with: String) -> String {
        let genreNames = genres.map { $0.name }
        return genreNames.joined(separator: with)
    }
}

struct TVDetail : Codable, GenreSeparatable{
    let name: String
    let id: Int
    let overview: String
    let genres: [Genre]
    let lastAirDate: String
    let number_of_seasons: Int
    let seasons: [Seasons]
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    struct Seasons: Codable {
        let episodeCount: Int
        let id: Int
        let name:String
        let overview:String
        let seasonNumber: Int
    }
    
    func separateGenres(with: String) -> String {
        let genreNames = genres.map { $0.name }
        return genreNames.joined(separator: with)
    }
    
}

//MARK: - GenreSeparatable Protocol

protocol GenreSeparatable {
    func separateGenres(with: String) -> String
}
