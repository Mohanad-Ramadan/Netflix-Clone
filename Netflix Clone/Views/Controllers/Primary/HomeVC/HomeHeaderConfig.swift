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
                let images = try await NetworkManager.shared.getImagesFor(mediaId: movie.id, ofType: "movie")
                let logoPath = UIHelper.getLogoDetailsFrom(images)?.0
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                
                // get genres
                let details: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: movie.id, ofType: "movie")
                
                // configure views
                self.heroHeaderView.configureHeaderView(with: MovieViewModel(logoPath: logoPath, backdropsPath: backdropPath, category: details.separateGenres(with: " • ")))
                self.homeBackground.configureBackground(with: MovieViewModel(backdropsPath: backdropPath))
                
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
}
