//
//  TableViewExtensions.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 07/12/2023.
//

import UIKit


extension NewAndHotVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewAndHotTableViewCell.identifier, for: indexPath) as? NewAndHotTableViewCell else {
            return UITableViewCell()
        }
        
        let entertainment = entertainments[indexPath.row]
        
        NetworkManager.shared.getImages(mediaType: entertainment.mediaType ?? "movie", id: entertainment.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedImages):
                    // logo
                    let logo : ImageDetails = {
                        let widthSorted = fetchedImages.logos.sorted {$0.aspectRatio > $1.aspectRatio}
                        if let englishLogo = widthSorted.first(where: { $0.iso6391 == "en" }) {
                            return englishLogo
                        } else if widthSorted.isEmpty {
                            return  ImageDetails(aspectRatio: 0, height: 0, filePath: "", voteAverage: 0.0, voteCount: 0, width: 0, iso6391: nil)
                        } else {
                            return widthSorted[0]
                        }
                    }()
                    let logoPath = logo.filePath
                    let logoAspectRatio = logo.aspectRatio
                    
                    // backdrop
                    let backdrop = fetchedImages.backdrops[0]
                    let backdropPath = backdrop.filePath

                    // cell images configuration
                    cell.configureCellImages(with: MovieViewModel(logoAspectRatio: logoAspectRatio, logoPath: logoPath, backdropsPath: backdropPath))
                case .failure(let failure):
                    print("Error getting images:", failure)
                    
                }
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
                        print(mediaType)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = EntertainmentDetailsVC()
        
        let entertainment = entertainments[indexPath.row]
        
        let isTrending = self.isTheTappedEntertainmentTrend
        let trendRank = indexPath.row+1
        
        let mediaType = entertainment.mediaType ?? "movie"
        let id = entertainment.id
        
        NetworkManager.shared.getDetails(mediaType: mediaType , id: id) { (result: Result<MovieDetail, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedDetials):
                    // detail
                    let detail = fetchedDetials
                    
                    // View Model congfigur
                    let viewModel = MovieViewModel(title: detail.title, overview: detail.overview, mediaType: mediaType ,releaseDate: detail.releaseDate, runtime: detail.runtime)
                    vc.configureDetails(with: viewModel, isTrending: isTrending!, rank: trendRank)
                    
                case .failure(let failure):
                    print("Error getting details:",failure)
                }
            }
        }
        
        NetworkManager.shared.getCast(mediaType: mediaType, id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCast):
                    // logo
                    let cast = fetchedCast.returnThreeCastSeperated(with: ", ")
                    let director = fetchedCast.returnDirector()
                    
                    // View Model congfigur
                    let viewModel = MovieViewModel(cast: cast, director: director)
                    vc.configureCast(with: viewModel)
                    
                case .failure(let failure):
                    print("Error getting Cast:", failure)
                    
                }
            }
        }
        
        NetworkManager.shared.getVedios(mediaType: mediaType, id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedVideos):
                    // YoutubeTrailers
                    let videos = fetchedVideos.returnYoutubeTrailers()
                    
                    // View Model congfigur
                    let viewModel = MovieViewModel(title: entertainment.title ,videosResult: videos)
                    vc.configureVideos(with: viewModel)
                    
                case .failure(let failure):
                    print("Error getting Vedios:", failure)   
                }
            }
        }
        
        presentInMainThread(vc)
    }
    
    
}
