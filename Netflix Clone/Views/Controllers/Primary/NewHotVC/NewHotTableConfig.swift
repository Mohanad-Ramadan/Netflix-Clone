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
                let images = try await NetworkManager.shared.getImagesFor(entertainmentId: entertainment.id, ofType: entertainment.mediaType!)
                // logo
                let logoPath = UIHelper.getLogoDetailsFrom(images)?.0
                let logoAspectRatio = UIHelper.getLogoDetailsFrom(images)?.1
                
                // backdrop
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                cell.configureCellImages(with: MovieViewModel(logoAspectRatio: logoAspectRatio, logoPath: logoPath, backdropsPath: backdropPath))
            } catch {
                print("Error getting images:", error.localizedDescription)
            }
        }
        
        if let mediaType = entertainment.mediaType,  mediaType == "tv" {
            NetworkManager.shared.getDetails(mediaType: mediaType , id: entertainment.id) { (result: Result<TVDetail, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedDetials):
                        // detail
                        let detail = fetchedDetials
                        let detailCategory = detail.separateGenres(with: " • ")
                        
                        // cell details configuration
                        cell.configureCellDetails(with: MovieViewModel(title: detail.name, overview: detail.overview, category: detailCategory, mediaType: entertainment.mediaType))
                    case .failure(let failure):
                        print("Error getting details:",failure)
                    }
                }
            }
        } else {
            NetworkManager.shared.getDetails(mediaType: entertainment.mediaType ?? "movie" , id: entertainment.id) { (result: Result<MovieDetail, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedDetials):
                        // detail
                        let detail = fetchedDetials
                        let detailCategory = detail.separateGenres(with: " • ")
                        
                        // cell details configuration
                        cell.configureCellDetails(with: MovieViewModel(title: detail.title, overview: detail.overview, category: detailCategory, mediaType: entertainment.mediaType ,releaseDate: detail.releaseDate))
                        
                    case .failure(let failure):
                        print(
                            "Error getting details:",
                            failure
                        )
                    }
                }
            }
        }
    }
    
}
