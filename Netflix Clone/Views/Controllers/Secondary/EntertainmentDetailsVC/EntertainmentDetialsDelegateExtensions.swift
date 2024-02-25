//
//  EntertainmentDetialsDelegateExtensions.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 23/01/2024.
//

import UIKit

//MARK: - CollectionView Delegate
extension EntertainmentDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreEntertainments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let poster = moreEntertainments[indexPath.row].posterPath ?? ""
        cell.configureTitle(with: poster)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        let entertainment = moreEntertainments[indexPath.row]
//        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
//        
//        NetworkManager.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async { [weak self] in
//                    let vc = EntertainmentDetailsVC()
//                    let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
//                    
//                    vc.configureMovieInfo(with: viewModel )
//                    vc.hidesBottomBarWhenPushed = true
//    self?.navigationController?.present(vc, animated: true)
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//        
//    }

}


//MARK: - TableView Delegate
extension EntertainmentDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailersTableViewCell.identifier, for: indexPath) as? TrailersTableViewCell else {
            return UITableViewCell()
        }
        
        let videoInfo = trailers[indexPath.row]
        guard let titleText = entertainmentName else { return UITableViewCell() }
        cell.configureCell(with: videoInfo, and: titleText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        let entertainment = entertainments[indexPath.row]
//        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
//        
//        
//        NetworkManager.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async { [weak self] in
//                    let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
//                    
//                    self?.delegate?.searchResultsDidTapped(viewModel)
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//        
//    }
    
    
}
