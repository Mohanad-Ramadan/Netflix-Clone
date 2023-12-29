//
//  EntertainmentImage.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 10/12/2023.
//

import Foundation


// MARK: - EntertainmentImage
struct EntertainmentLogo: Codable {
    let logos: [Detail]
}

// MARK: - EntertainmentImage
struct EntertainmentPoster: Codable {
    let posters: [Detail]
}

// MARK: - Detail
struct Detail: Codable {
    let aspectRatio: Double
    let height: Int
    let filePath: String
    let voteAverage: Double
    let width: Int
    var iso6391: String?
}

