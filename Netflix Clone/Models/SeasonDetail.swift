//
//  SeasonDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/03/2024.
//

import Foundation

struct SeasonDetail: Codable {
    let id: Int
    let airDate: String
    let episodes: [Episode]
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double
    
    struct Episode: Codable {
        let airDate: String?
        let episodeNumber: Int?
        let episodeType: String?
        let id: Int?
        let name: String?
        let overview: String?
        let productionCode: String?
        let runtime: Int?
        let seasonNumber: Int?
        let showId: Int?
        let stillPath: String?
        let voteAverage: Double?
        let voteCount: Int?
    }
}


