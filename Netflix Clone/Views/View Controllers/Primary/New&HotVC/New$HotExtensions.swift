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
        
        var movie = entertainments[indexPath.row]
        
        APICaller.shared.getLogo(mediaType: movie.mediaType ?? "movie", id: movie.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let logo):
                    movie.logoPath = logo.filePath
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        cell.configureCell(with: MovieViewModel(titleName: movie.title ?? "Unknown", posterPath: movie.posterPath ?? "Unknown", logo: movie.logoPath ?? "Unknown", mediaType: movie.mediaType))
        
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

