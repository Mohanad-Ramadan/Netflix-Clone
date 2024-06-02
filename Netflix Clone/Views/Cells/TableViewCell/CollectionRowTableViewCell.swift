//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import UIKit

class CollectionRowTableViewCell: UITableViewCell {
    // Delegate protocol
    protocol Delegate: AnyObject {
        func collectionCellDidTapped(_ cell: CollectionRowTableViewCell, navigateTo vc: MediaDetailsVC)
    }
    
    //MARK: Declare Variables
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
    
    
    //MARK: - Load View
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
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Prepare Cell
    override func prepareForReuse() {
        super.prepareForReuse()
        media = []
        collectionView.reloadData()
    }
    
    //MARK: - Setup View
    func configureCollection(with media: [Media]){
        self.media = media
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func addToMyList(_ indexpath: IndexPath ) {
        Task {
            try await PersistenceDataManager.shared.addToMyListMedia(media[indexpath.row])
            NotificationCenter.default.post(name: NSNotification.Name(NotificationKey.myListKey), object: nil)
        }
    }
     
}


//MARK: - Collection Cell Delegate
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
        
        if media.title != nil {
            let vc = MovieDetailsVC(for: media)
            self.delegate?.collectionCellDidTapped(self, navigateTo: vc)
        } else if media.originalName != nil {
            let vc = TVDetailsVC(for: media)
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


