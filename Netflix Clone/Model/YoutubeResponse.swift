//
//  YoutubeResponse.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 18/10/2023.
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



