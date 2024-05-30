//
//  MovieDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation

protocol Detail {var title: String? {get}}

struct MovieDetail : Detail ,Codable{
    var title: String?
    let id: Int
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    let runtime: Int
    
    func separateGenres(with: String) -> String {
        let genreNames = genres.map { $0.name }
        return genreNames.joined(separator: with)
    }
}

struct TVDetail : Detail ,Codable{
    var title: String?
    let name: String
    let id: Int
    let overview: String
    let genres: [Genre]
    let lastAirDate: String
    let numberOfSeasons: Int?
    let seasons: [Season]
    
    struct Season: Codable {
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

struct Genre: Codable {
    let id: Int
    let name: String
}
