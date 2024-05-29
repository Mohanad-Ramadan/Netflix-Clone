//
//  YoutubeResponse.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import Foundation


struct YoutubeResponse: Codable {
    let items: [VideoObject]
    
    struct VideoObject: Codable {
        let id: IdObject
        
        struct IdObject: Codable {
            let videoId: String
        }
    }
}



