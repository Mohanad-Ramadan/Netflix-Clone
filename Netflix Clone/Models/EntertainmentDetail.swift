//
//  EntertainmentDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation

// MARK: - Entertinment Detials
struct MovieDetail : Codable{
    let title: String
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    func seperateGenres(with: String) -> String {
        let genreNames = genres.map { $0.name }
        return genreNames.joined(separator: with)
    }
}

struct TVDetail : Codable{
    let originalName: String
    let overview: String
    let genres: [Genre]
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    func seperateGenres(with: String) -> String {
        let genreNames = genres.map { $0.name }
        return genreNames.joined(separator: with)
    }
}
