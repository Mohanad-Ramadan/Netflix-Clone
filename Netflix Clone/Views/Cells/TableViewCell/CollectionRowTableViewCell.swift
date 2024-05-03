//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class CollectionRowTableViewCell: UITableViewCell {
    
    //MARK: Delegate Protocol
    protocol Delegate: AnyObject {
        func collectionCellDidTapped(_ cell: CollectionRowTableViewCell, navigateTo vc: MediaDetailsVC)
    }
    
    
    //MARK: - Cell Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    //MARK: - Configure Cell
    func configureCollection(with media: [Media]){
        self.media = media
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func addToMyList(_ indexpath: IndexPath ) {
        Task {
            try await PersistenceDataManager.shared.addToMyListMedia(media[indexpath.row])
            NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationKey), object: nil)
        }
    }
     
    
    //MARK: - Declare UIElements
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 115, height: 170)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var media: [Media] = [Media]()
    
    static let identifier = "HomeTableViewCell"
    weak var delegate: Delegate?
    
    required init?(coder: NSCoder) {fatalError()}
}


//MARK: - CollectionRowTableViewCell extensions
extension CollectionRowTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        let poster = media[indexPath.row].posterPath ?? ""
        cell.configureCell(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let media = media[indexPath.row]
//        let isTrend = self.isTheTappedMediaTrend!
        let trendRank = indexPath.row+1
        
        if media.mediaType == nil || media.mediaType == "movie" {
            let vc = MovieDetailsVC(for: media, rank: trendRank)
            self.delegate?.collectionCellDidTapped(self, navigateTo: vc)
        } else {
            let vc = TVDetailsVC(for: media, rank: trendRank)
            self.delegate?.collectionCellDidTapped(self, navigateTo: vc)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
            let addToListAction = UIAction(title: "Add to List", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.addToMyList(indexPath)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [addToListAction])
        }
        return config
        
    }
    
}


