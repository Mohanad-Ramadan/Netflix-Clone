//
//  Movies.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/10/2023.
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


