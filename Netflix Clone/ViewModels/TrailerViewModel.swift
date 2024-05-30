//
//  TrailerViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 30/05/2024.
//

import Foundation

class TrailerViewModel {
    init(_ trailers: [Trailer.Reuslts]) {self.trailers = trailers}
    
    private let trailers: [Trailer.Reuslts]
    
    var firstTrailerKey: String {
        let trailerInfo = trailers.filter { "Trailer".contains($0.type) }
        let firstTrailer = trailerInfo.map { $0.key }[0]
        return firstTrailer
    }
    
    var trailersCount: Int?
    
    // pass other trailers without the first trailer
    func getSomeTrailers(withTotal totalTrailers: Int) -> [Trailer.Reuslts] {
        let otherTrailers = trailers.filter { $0.key != firstTrailerKey }
        let someTrailers = Array(otherTrailers.prefix(totalTrailers))
        trailersCount = someTrailers.count
        return someTrailers
    }
    
}
