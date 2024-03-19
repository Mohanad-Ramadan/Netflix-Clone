//
//  HomeHeaderConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 16/01/2024.
//

import UIKit

extension HomeVC {
    func setupHeaderAndBackground() {
        Task{
            do {
                let movies = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                let randomMovie = movies.randomElement()
                self.fetchImagesAndConfigureViews(for: randomMovie!)
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
        Task {
            do {
                // get logo and backdrop
                let images = try await NetworkManager.shared.getImagesFor(mediaId: movie.id, ofType: movie.mediaType!)
                let logoPath = UIHelper.getLogoDetailsFrom(images)?.0
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                self.heroHeaderView.configureHeaderView(with: MovieViewModel(logoPath: logoPath, backdropsPath: backdropPath))
                self.homeBackground.configureBackground(with: MovieViewModel(backdropsPath: backdropPath))
                
                // get genres
                self.fetchAndConfigureDetails(for: movie, fetchType: MovieDetail.self)
                
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
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
    
}
