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
        
        let movie = entertainments[indexPath.row]
        
        APICaller.shared.getImages(mediaType: movie.mediaType ?? "movie", id: movie.id) { result in
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
        
        if let mediaType = movie.mediaType,  mediaType == "tv" {
            APICaller.shared.getDetails(mediaType: mediaType , id: movie.id) { (result: Result<TVDetail, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedDetials):
                        // detail
                        let detail = fetchedDetials
                        let detailCategory = detail.separateGenres(with: " • ")
                        
                        // cell details configuration
                        cell.configureCellDetails(with: MovieViewModel(title: detail.originalName, overview: detail.overview, category: detailCategory, mediaType: movie.mediaType))
                    case .failure(let failure):
                        print("Error getting details:",failure)
                    }
                }
            }
        } else {
            APICaller.shared.getDetails(mediaType: movie.mediaType ?? "movie" , id: movie.id) { (result: Result<MovieDetail, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedDetials):
                        // detail
                        let detail = fetchedDetials
                        let detailCategory = detail.separateGenres(with: " • ")
                        
                        // cell details configuration
                        cell.configureCellDetails(with: MovieViewModel(title: detail.title, overview: detail.overview, category: detailCategory, mediaType: movie.mediaType ,releaseDate: detail.releaseDate))
                        
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
        
        let entertainment = entertainments[indexPath.row]
        
        APICaller.shared.getDetails(mediaType: "movie" , id: entertainment.id) { (result: Result<MovieDetail, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedDetials):
                    // detail
                    let detail = fetchedDetials
                    
                    // View Model congfigur
                    let viewModel = MovieViewModel(title: detail.title, overview: detail.overview, mediaType: "movie" ,releaseDate: detail.releaseDate)
                    
                    // Push to VC
                    let vc = EntertainmentDetailsVC()
                    vc.configureModelViewDetails(with: viewModel)
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.present(vc, animated: true)
                    
                case .failure(let failure):
                    print("Error getting details:",failure)
                }
            }
        }
        
        
        
        
//        APICaller.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async { [weak self] in
//                    
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
        
    }
    
    
}

