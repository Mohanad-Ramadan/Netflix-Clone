//
//  EntertainmentDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation

// MARK: - Entertinment Detials
struct Detail : Codable{
    let title: String
    let backdropPath: String
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    func formattedGenres() -> String {
        let genreNames = genres.map { $0.name }
        return genreNames.joined(separator: ", ")
    }
}
