//
//  HomeTableViewExtension.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

//MARK: - HomeTableViewCell extensions

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
        let poster = entertainments[indexPath.row].posterPath ?? ""
        cell.configureCell(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let media = entertainments[indexPath.row]
//        let isTrend = self.isTheTappedEntertainmentTrend!
        let trendRank = indexPath.row+1
        
        if media.mediaType == nil || media.mediaType == "movie" {
            let vc = MovieDetailsVC(for: media, rank: trendRank)
            self.delegate?.homeTableViewCellDidTapped(self, navigateTo: vc)
        } else {
            let vc = TVDetailsVC(for: media, rank: trendRank)
            self.delegate?.homeTableViewCellDidTapped(self, navigateTo: vc)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadEntertainmentAt(indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
        
    }
    
}


