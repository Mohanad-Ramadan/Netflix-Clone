//
//  Movies.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/10/2023.
//

import Foundation


struct EntertainmentResponse: Codable {
    let results: [Entertainment]
}

struct Entertainment: Codable, Hashable {
    let id: Int
    let originalName: String?
    let title: String?
    let overview: String?
    let mediaType: String?
    let posterPath: String?

}


