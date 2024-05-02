//
//  MediaViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 15/10/2023.
//

import Foundation

struct MediaViewModel {
    
    // Basic Parameter
    var title: String?
    var overview: String?
    var id: Int?
    var posterPath: String?
    
    // Logo Parameter
    var logoAspectRatio: Double?
    var logoPath: String?
    
    // Backdrop Parameter
    var backdropsPath: String?
    
    // Detail Parameter
    var genres: [Genre]?
    var category: String?
    var mediaType: String?
    var releaseDate: String?
    var runtime: Int?
    
    // Casting Parameter
    var cast: String?
    var director: String?
    
    // Trailers Parameter
    var videosResult: [Trailer.Reuslts]?
    
}
