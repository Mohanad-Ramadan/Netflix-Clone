//
//  HomeHeaderConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 16/01/2024.
//

import UIKit

extension HomeVC {
    //MARK: - Setup Header tap gesture
    func setupHeroHeaderTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTapGesture))
        heroHeaderView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleHeaderTapGesture() {
        guard let media = heroHeaderMedia else {return}
        if media.mediaType == nil || media.mediaType == "movie" {
            let vc = MovieDetailsVC(for: media)
            presentAsRoot(vc)
        } else {
            let vc = TVDetailsVC(for: media)
            presentAsRoot(vc)
        }
    }
    
    //MARK: - Setup Header Data
    func setupHeaderAndBackground() {
        Task{
            do {
                let movies = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                let randomMovie = movies.randomElement()!
                self.fetchImagesAndConfigureViews(for: randomMovie)
            } catch let error as APIError {
                presentNFAlert(messageText: error.rawValue)
            } catch {
                presentTemporaryAlert(alertType: .connectivity)
            }
        }
    }
    
    private func fetchImagesAndConfigureViews(for movie: Media) {
        Task {
            do {
                // get logo and backdrop
                let images = try await NetworkManager.shared.getImagesFor(mediaId: movie.id, ofType: "movie")
                let logoPath = UIHelper.getLogoDetailsFrom(images)?.0
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                
                // get genres
                let details: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: movie.id, ofType: "movie")
                
                // configure views
                heroHeaderMedia = movie
                
                heroHeaderView.media = movie
                heroHeaderView.configureHeaderView(with: MediaViewModel(logoPath: logoPath, backdropsPath: backdropPath, category: details.separateGenres(with: " • ")))
                homeBackground.configureBackground(with: MediaViewModel(backdropsPath: backdropPath))
                
            } catch let error as APIError {
                presentNFAlert(messageText: error.rawValue)
            } catch {
                presentTemporaryAlert(alertType: .connectivity)
            }
        }
    }
    
}
