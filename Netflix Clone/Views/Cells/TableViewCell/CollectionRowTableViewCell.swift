//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class CollectionRowTableViewCell: UITableViewCell {
    // Delegate Protocol
    protocol Delegate: AnyObject {
        func homeTableViewCellDidTapped(_ cell: CollectionRowTableViewCell, navigateTo vc: MediaDetailsVC)
    }
    
    // Configure TableViewCell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: 9, y: 0, width: Int(contentView.bounds.width), height: Int(contentView.bounds.height))
    }
    
    
    func configureCollection(with media: [Media]){
        self.media = media
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func downloadMediaAt(_ indexpath: IndexPath ) {
        DataPersistenceManager.shared.downloadMediaWith(model: media[indexpath.row]) { results in
            switch results {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationKey), object: nil)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    static let identifier = "HomeTableViewCell"
    
    weak var delegate: Delegate?
    
    var media: [Media] = [Media]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 115, height: 170)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:\(coder) has not been implemented")
    }
}


//MARK: - CollectionRowTableViewCell extensions
extension CollectionRowTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
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
            self.delegate?.homeTableViewCellDidTapped(self, navigateTo: vc)
        } else {
            let vc = TVDetailsVC(for: media, rank: trendRank)
            self.delegate?.homeTableViewCellDidTapped(self, navigateTo: vc)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadMediaAt(indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
        
    }
    
}


