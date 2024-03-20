//
//  NewHotTableConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 08/03/2024.
//

import Foundation

extension NewHotVC {
    
    func setDataSource(for cell: NewAndHotTableViewCell ,from entertainment: Entertainment) {
        
        Task {
            do {
                let id = entertainment.id
                let mediaType = entertainment.mediaType
                
                // images
                let images = try await NetworkManager.shared.getImagesFor(mediaId: id, ofType: mediaType ?? "movie")
                let logoPath = UIHelper.getLogoDetailsFrom(images)?.0
                let logoAspectRatio = UIHelper.getLogoDetailsFrom(images)?.1
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                cell.configureCellImages(with: MovieViewModel(logoAspectRatio: logoAspectRatio, logoPath: logoPath, backdropsPath: backdropPath))
                
                // details
                if mediaType == nil || mediaType == "movie" {
                    let detail: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: id, ofType: "movie")
                    let detailCategory = detail.separateGenres(with: " • ")
                    cell.configureCellDetails(with: MovieViewModel(title: detail.title, overview: detail.overview, category: detailCategory, mediaType: entertainment.mediaType ,releaseDate: detail.releaseDate))
                } else {
                    let detail: TVDetail = try await NetworkManager.shared.getDetailsFor(mediaId: id, ofType: "tv")
                    let detailCategory = detail.separateGenres(with: " • ")
                    cell.configureCellDetails(with: MovieViewModel(title: detail.name, overview: detail.overview, category: detailCategory, mediaType: entertainment.mediaType))
                }
            } catch { print("Error getting images:", error.localizedDescription) }
            
        }
         
    }
    
}
