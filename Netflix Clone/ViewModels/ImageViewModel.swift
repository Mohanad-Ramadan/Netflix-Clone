//
//  ImageViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import Foundation

struct ImageViewModel {
    
    private let images: MediaImage
    
    init(_ images: MediaImage) {self.images = images}
    
    
    var logoPath: String? {
        guard let englishLogo = images.logos.first(where: { $0.iso6391 == "en" }) else {
            return images.logos.first?.filePath
        }
        return englishLogo.filePath
    }
    
    
    var logoAspectRatio: Double? {
        guard let englishLogo = images.logos.first(where: { $0.iso6391 == "en" }) else {
            return images.logos.first?.aspectRatio
        }
        return englishLogo.aspectRatio
    }
    
    var backdropsPath: String? { images.backdrops.first?.filePath }

}
