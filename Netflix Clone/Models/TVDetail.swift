//
//  TVDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/03/2024.
//

import Foundation

struct TVDetail : Codable{
    let name: String
    let id: Int
    let overview: String
    let genres: [Genre]
    let lastAirDate: String
    let numberOfSeasons: Int?
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


struct Season: Codable {
    let id: String
    let airDate: String
    let episodes: [Episode]
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double
    
    struct Episode: Codable {
        let airDate: String
        let episodeNumber: Int
        let episodeType: String
        let id: Int
        let name: String
        let overview: String
        let productionCode: String
        let runtime: Int
        let seasonNumber: Int
        let showId: Int
        let stillPath: String?
        let voteAverage: Double
        let voteCount: Int
    }
}


