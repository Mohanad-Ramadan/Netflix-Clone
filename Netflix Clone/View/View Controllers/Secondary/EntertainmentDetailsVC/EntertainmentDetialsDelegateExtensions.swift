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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let poster = moreEntertainments[indexPath.row].posterPath ?? ""
        cell.configureTitle(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let entertainment = moreEntertainments[indexPath.row]
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


//MARK: - TableView Delegate

