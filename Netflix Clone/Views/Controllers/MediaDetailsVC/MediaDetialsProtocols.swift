//
//  MediaDetialsProtocols.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 23/01/2024.
//

import UIKit

//MARK: - CollectionView Delegate
extension MediaDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreMedias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let poster = moreMedias[indexPath.row].posterPath ?? ""
        cell.configureCell(with: poster)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        let media = moreMedias[indexPath.row]
//        guard let mediaName = media.title ?? media.originalName else {return}
//        
//        NetworkManager.shared.getYoutubeTrailer(query: mediaName + " trailer") { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async { [weak self] in
//                    let vc = MediaDetailsVC()
//                    let viewModel = MovieInfoViewModel(title: mediaName, youtubeVideo: videoElement, titleOverview: media.overview ?? "Unknown")
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

