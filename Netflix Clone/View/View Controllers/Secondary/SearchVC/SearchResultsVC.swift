//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 16/10/2023.
//

import UIKit

class SearchResultsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
    
    public weak var delegate: SearchResultsVCDelegate?
    
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3-10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return collectionView
    }()
    
    var entertainments: [Entertainment] = [Entertainment]()
    

}


//MARK: - SearchResults extension

extension SearchResultsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let poster = entertainments[indexPath.row].posterPath ?? ""
        cell.configureTitle(with: poster)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let entertainment = entertainments[indexPath.row]
        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
        
        APICaller.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
                
                self?.delegate?.searchResultsDidTapped(viewModel)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

}




//MARK: - cellTapped method in protocol


protocol SearchResultsVCDelegate: AnyObject {
    func searchResultsDidTapped(_ viewModel: MovieInfoViewModel)
}

