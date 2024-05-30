//
//  MovieDetail.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation

protocol Detail {
    var title: String? {get}
    var id: Int {get}
    var overview: String? {get}
    var genres: [Genre] {get}
}

struct MovieDetail : Detail ,Codable{
    var title: String?
    var id: Int
    var overview: String?
    var genres: [Genre]
    let releaseDate: String?
    let runtime: Int?
}

struct TVDetail : Detail ,Codable{
    var title: String?
    var id: Int
    var overview: String?
    var genres: [Genre]
    let name: String?
    let firstAirDate: String?
    let numberOfSeasons: Int?
    let seasons: [Season]?
}

struct Season: Codable {
    let episodeCount: Int?
    let id: Int
    let name: String?
    let overview: String?
    let seasonNumber: Int?
}

struct Genre: Codable {
    let id: Int
    let name: String
}
