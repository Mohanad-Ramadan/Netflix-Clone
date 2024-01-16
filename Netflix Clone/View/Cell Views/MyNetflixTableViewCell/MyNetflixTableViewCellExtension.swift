//
//  MyNetflixTableViewCellExtension.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

//MARK: - MyNetflixTableViewCell extensions

extension MyNetflixTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        let poster = entertainments[indexPath.row].posterPath ?? ""
        cell.configureTitle(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let entertainment = entertainments[indexPath.row]
        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
        
        APICaller.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let entertainment = self?.entertainments[indexPath.row]
                guard let movieOverview = entertainment?.overview else {
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: movieOverview)
                self?.delegate?.myNetflixTableViewCellDidTapped(strongSelf, viewModel: viewModel)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}

//MARK: - cellTapped method in protocol

protocol MyNetflixTableViewCellDelegate: AnyObject {
    func myNetflixTableViewCellDidTapped(_ cell: MyNetflixTableViewCell, viewModel: MovieInfoViewModel)
}

