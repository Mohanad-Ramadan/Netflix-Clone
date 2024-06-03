//
//  MyNetflixTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

//MARK: List Container Cases
enum ListContainer { case myList, watchedList}

class MyNetflixTableViewCell: UITableViewCell {
    // Delegate protocol
    protocol Delegate: AnyObject {func cellDidTapped(_ cell: MyNetflixTableViewCell, navigateTo vc: MediaDetailsVC)}
    
    //MARK: Declare Variables
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
    
    var media: [Media] = [Media]()
    var listContainer: ListContainer?
    
    weak var delegate: Delegate?
    static let identifier = "MyNetflixTableViewCell"
    
    
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
    
    
    //MARK: - Setup View
    func configureCollection(with media: [Media], list: ListContainer){
        listContainer = list
        DispatchQueue.main.async { [weak self] in
            self?.media = media
            self?.collectionView.reloadData()
        }
    }
    
    
    private func removeMylistCell(at indexpath: IndexPath) {
        Task {
            try await PersistenceDataManager.shared.deleteMediaFromList(media[indexpath.row])
            self.media.remove(at: indexpath.row)
            collectionView.deleteItems(at: [indexpath])
        }
    }
    
    private func removeWatchedCell(at indexpath: IndexPath) {
        Task {
            try await PersistenceDataManager.shared.deleteMediaFromWatched(media[indexpath.row])
            self.media.remove(at: indexpath.row)
            collectionView.deleteItems(at: [indexpath])
        }
    }
    
}


//MARK: - Delegates and DataSource

extension MyNetflixTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
        let poster = media[indexPath.row].posterPath ?? ""
        cell.configureCell(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        switch listContainer {
        case .myList:
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
                let removeCellAction = UIAction(title: "Delete", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.removeMylistCell(at: indexPath)
                }
                
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [removeCellAction])
            }
            return config
        case .watchedList:
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
                let removeCellAction = UIAction(title: "Delete", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.removeWatchedCell(at: indexPath)
                }
                
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [removeCellAction])
            }
            return config
        case .none: return nil
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let media = media[indexPath.row]
        
        if media.title != nil {
            let vc = MovieDetailsVC(for: media)
            self.delegate?.cellDidTapped(self, navigateTo: vc)
        } else if media.originalName != nil {
            let vc = TVDetailsVC(for: media)
            self.delegate?.cellDidTapped(self, navigateTo: vc)
        }
        
    }
    
}
