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
        let vc = EntertainmentDetailsVC()
        
        let entertainment = entertainments[indexPath.row]
        
        let trendRank = indexPath.row+1
        
        let mediaType = entertainment.mediaType ?? "movie"
        let id = entertainment.id
        
        Task {
            do {
                // get details
                let details: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: id, ofType: mediaType)
                let viewModel = MovieViewModel(title: details.title, overview: details.overview, mediaType: mediaType ,releaseDate: details.releaseDate, runtime: details.runtime)
                vc.configureDetails(with: viewModel/*, isTrending: isTrending!*/, rank: trendRank)
                
                // get cast
                let fetchedCast = try await NetworkManager.shared.getCastFor(mediaId: id, ofType: mediaType)
                let cast = fetchedCast.returnThreeCastSeperated(with: ", ")
                let director = fetchedCast.returnDirector()
                vc.configureCast(with: MovieViewModel(cast: cast, director: director))
                
                // get trailers
//                let trailers = try await NetworkManager.shared.getTrailersFor(mediaId: id, ofType: mediaType).returnYoutubeTrailers()
//                vc.configureVideos(with: MovieViewModel(title: details.title ,videosResult: trailers))
                
            } catch {
                print(error.localizedDescription)
            }
        }

//        NetworkManager.shared.getDetails(mediaType: mediaType , id: id) { (result: Result<MovieDetail, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let fetchedDetials):
//                    // detail
//                    let detail = fetchedDetials
//                    
//                    // View Model congfigur
//                    let viewModel = MovieViewModel(title: detail.title, overview: detail.overview, genres: detail.genres, mediaType: mediaType ,releaseDate: detail.releaseDate, runtime: detail.runtime)
//                    vc.configureDetails(with: viewModel, isTrending: false, rank: trendRank)
//                    
//                case .failure(let failure):
//                    print("Error getting details:",failure)
//                }
//            }
//        }
//
//        NetworkManager.shared.getCast(mediaType: mediaType, id: id) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let fetchedCast):
//                    // logo
//                    let cast = fetchedCast.returnThreeCastSeperated(with: ", ")
//                    let director = fetchedCast.returnDirector()
//
//                    // View Model congfigur
//                    let viewModel = MovieViewModel(cast: cast, director: director)
//                    vc.configureCast(with: viewModel)
//                    
//                case .failure(let failure):
//                    print("Error getting Cast:", failure)
//
//                }
//            }
//        }
//
//        NetworkManager.shared.getVedios(mediaType: mediaType, id: id) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let fetchedVideos):
//                    // YoutubeTrailers
//                    let videos = fetchedVideos.returnYoutubeTrailers()
//
//                    // View Model congfigur
//                    let viewModel = MovieViewModel(title: entertainment.title ,videosResult: videos)
//                    vc.configureVideos(with: viewModel)
//
//                case .failure(let failure):
//                    print("Error getting Vedios:", failure)
//                }
//            }
//        }
        
        self.delegate?.homeTableViewCellDidTapped(self, navigateTo: vc)
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

//MARK: - cellTapped method in protocol

protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCellDidTapped(_ cell: HomeTableViewCell, navigateTo vc: EntertainmentDetailsVC)
}
