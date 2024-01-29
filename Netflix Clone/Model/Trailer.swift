//
//  Trailer.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/01/2024.
//

import Foundation

// MARK: - Cast
struct Trailer: Codable, TrailerReturn {
    let results: [Reuslts]
    
    struct Reuslts: Codable{
        let name: String
        let publishedAt: String
        let site: String
        let type: String
    }
    
    func returnYoutubeTrailers() -> [Trailer.Reuslts] {
        let youtube = results.filter { $0.site == "YouTube" }
        let desiredVideosArray = ["Trailer","Teaser","Clip","Opening Credits"]
        let desiredVideos = youtube.filter { desiredVideosArray.contains($0.type) }
        return desiredVideos
    }
}

//MARK: - Protocols

protocol TrailerReturn {
    func returnYoutubeTrailers() -> [Trailer.Reuslts]
}
