//
//  HomeHeaderConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 16/01/2024.
//

import UIKit

extension HomeVC {
    func fetchHeaderAndBackgound() {
        Task{
            do {
                let movies = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                let randomMovie = movies.randomElement()
                self.fetchImagesAndConfigureViews(for: randomMovie!)
                
//                let movieImages = try await NetworkManager.shared.getImageFor(entertainmentId: randomMovie!.id, ofType: "movie")
                
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImagesAndConfigureViews(for movie: Entertainment) {
        NetworkManager.shared.getImages(mediaType: movie.mediaType ?? "movie", id: movie.id) { result in
            switch result {
            case .success(let fetchedImages):
                self.configureHeader(with: fetchedImages, for: movie)
            case .failure(let failure):
                print("Error getting images:", failure)
            }
        }
    }
    
    private func configureHeader(with fetchedImages: Image, for movie: Entertainment) {
        let logoPath = getLogoPath(from: fetchedImages)
        let backdropPath = getBackdropPath(from: fetchedImages)
        
        self.heroHeaderView.configureHeaderView(with: MovieViewModel(logoPath: logoPath, backdropsPath: backdropPath))
        self.homeBackground.configureBackground(with: MovieViewModel(backdropsPath: backdropPath))
        
        if movie.mediaType == "movie" {
            self.fetchAndConfigureDetails(for: movie, fetchType: MovieDetail.self)
        } else {
            self.fetchAndConfigureDetails(for: movie, fetchType: TVDetail.self)
        }
    }
    
    private func fetchAndConfigureDetails<T: Decodable & GenreSeparatable>(for movie: Entertainment, fetchType: T.Type) {
        NetworkManager.shared.getDetails(mediaType: movie.mediaType!, id: movie.id) { (result: Result<T, Error>) in
            switch result {
            case .success(let fetchedDetails):
                let detailCategory = fetchedDetails.separateGenres(with: " • ")
                self.heroHeaderView.configureHeaderView(with: MovieViewModel(category: detailCategory))
            case .failure(let failure):
                print("Error getting details:", failure)
            }
        }
    }
    
    private func getLogoPath(from fetchedImages: Image) -> String {
        let logos = fetchedImages.logos
        if let englishLogo = logos.first(where: { $0.iso6391 == "en" }) {
            return englishLogo.filePath
        } else if logos.isEmpty {
            return ImageDetails(aspectRatio: 0, height: 0, filePath: "", voteAverage: 0.0, voteCount: 0, width: 0, iso6391: nil).filePath
        } else {
            return logos[0].filePath
        }
    }
    
    private func getBackdropPath(from fetchedImages: Image) -> String {
        let backdrop = fetchedImages.backdrops.sorted(by: {$0.voteAverage > $1.voteAverage})[0]
        return backdrop.filePath
    }
}
