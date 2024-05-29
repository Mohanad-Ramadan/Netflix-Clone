//
//  Movies.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import Foundation


struct MediaResponse: Codable {
    let results: [Media]
}

struct Media: Codable {
    let id: Int
    let originalName: String?
    let title: String?
    let overview: String?
    let mediaType: String?
    let posterPath: String?

}


