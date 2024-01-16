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
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    
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
    let originalName: String
    let overview: String
    let genres: [Genre]
    
    struct Genre: Codable {
        let id: Int
        let name: String
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
