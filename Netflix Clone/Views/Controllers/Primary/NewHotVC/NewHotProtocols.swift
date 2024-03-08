//
//  NewHotProtocols.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 07/12/2023.
//

import UIKit


extension NewHotVC: UITableViewDelegate,
                    UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewAndHotTableViewCell.identifier, for: indexPath) as? NewAndHotTableViewCell else {return UITableViewCell()}
        let entertainment = entertainments[indexPath.row]
        setDataSource(for: cell, from: entertainment)
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

//extension NewHotVC: NewAndHotTableViewCellDelegate {
//    func finishLoadingPoster() {
//        loadingView.removeFromSuperview()
//    }
//}
