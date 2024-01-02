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
        
        APICaller.shared.getImages(mediaType: movie.mediaType, id: movie.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedImages):
                    // logo
                    let logo : ImageDetails = {
                        let widthSorted = fetchedImages.logos.sorted {$0.aspectRatio > $1.aspectRatio}
                        let englishLogo = widthSorted.filter {$0.iso6391 == "en"}[0]
                        return englishLogo
                    }()
                    let logoPath = logo.filePath
                    let logoAspectRatio = logo.aspectRatio
                    
                    // backdrop
                    let backdrop = fetchedImages.backdrops.filter{$0.aspectRatio >= 1.6 && $0.aspectRatio <= 2}[0]
                    let backdropPath = backdrop.filePath

                    // cell images configuration
                    cell.configureCellImages(with: MovieViewModel(logoAspectRatio: logoAspectRatio, logoPath: logoPath, backdropsPath: backdropPath))
                case .failure(let failure):
                    print("Error getting images:", failure)
                    
                }
            }
        }
        
        APICaller.shared.getDetails(mediaType: movie.mediaType , id: movie.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedDetials):
                    // detail
                    let detail = fetchedDetials
                    let detailCategory = detail.formattedGenres()
                    
                    // cell details configuration
                    cell.configureCellDetails(with: MovieViewModel(title: detail.title, overview: detail.overview, category: detailCategory, mediaType: movie.mediaType ,date: detail.releaseDate))
                case .failure(let failure):
                    print(
                        "Error getting details:",
                        failure
                    )
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entertainment = entertainments[indexPath.row]
        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
        
        
        APICaller.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async { [weak self] in
                    let vc = MovieInfoVC()
                    let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
                    
                    vc.configureMovieInfo(with: viewModel )
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    
}

