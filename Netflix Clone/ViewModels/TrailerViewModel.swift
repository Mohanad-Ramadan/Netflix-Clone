//
//  TrailerViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 30/05/2024.
//

import Foundation

class TrailerViewModel {
    
    private let trailers: Trailer
    
    init(_ trailers: Trailer) {self.trailers = trailers}
    
    
    private var trailerResults: [Trailer.Reuslts] {
        let youtube = trailers.results.filter { $0.site == "YouTube" }
        let desiredVideosArray = ["Trailer","Teaser","Clip","Opening Credits"]
        let desiredVideos = youtube.filter { desiredVideosArray.contains($0.type) }
        return desiredVideos
    }
    
    
    var firstTrailerKey: String {
        let trailerInfo = trailerResults.filter { "Trailer".contains($0.type) }
        let firstTrailer = trailerInfo.map { $0.key }[0]
        return firstTrailer
    }
    
    var trailersCount: Int?
    
    // pass other trailers without the first trailer
    func getSomeTrailers(withTotal totalTrailers: Int) -> [Trailer.Reuslts] {
        let otherTrailers = trailerResults.filter { $0.key != firstTrailerKey }
        let someTrailers = Array(otherTrailers.prefix(totalTrailers))
        trailersCount = someTrailers.count
        return someTrailers
    }
    
}
