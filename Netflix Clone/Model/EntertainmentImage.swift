//
//  EntertainmentImage.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation


// MARK: - EntertainmentImage
struct EntertainmentImage: Codable {
    let logos: [ImageDetails]
    let backdrops: [ImageDetails]
}

// MARK: - Images Detail
struct ImageDetails: Codable {
    let aspectRatio: Double
    let height: Int
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int
    var iso6391: String?
}

