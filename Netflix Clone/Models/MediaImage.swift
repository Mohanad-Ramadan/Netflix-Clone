//
//  MediaImage.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/01/2024.
//

import Foundation


// MARK: - MediaImage
struct MediaImage: Codable {
    let logos: [ImageDetail]
    let backdrops: [ImageDetail]
}

// MARK: - Images Detail
struct ImageDetail: Codable {
    let aspectRatio: Double
    let height: Int
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int
    var iso6391: String?
}

