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
    
    let logoAspectRatio = UIHelper.getLogoDetailsFrom(images)?.1
    let logoPath = UIHelper.getLogoDetailsFrom(images)?.0
    let backdropPath = UIHelper.getBackdropPathFrom(images)
    
    // get LogoPath
    static func getLogoDetailsFrom(_ fetchedImages: MediaImage) -> (String,Double)? {
        let logos = fetchedImages.logos
        
        if logos.isEmpty {
            return nil
        } else if let englishLogo = logos.first(where: { $0.iso6391 == "en" }) {
            return (englishLogo.filePath, englishLogo.aspectRatio)
        } else {
            return (logos[0].filePath, logos[0].aspectRatio)
        }
    }
    
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
