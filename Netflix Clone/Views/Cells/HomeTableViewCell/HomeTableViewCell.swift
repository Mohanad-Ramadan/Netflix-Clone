//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit
import SkeletonView

protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCellDidTapped(_ cell: HomeTableViewCell, navigateTo vc: MediaDetailsVC)
}

class HomeTableViewCell: UITableViewCell {
    
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
    
    
    func configureCollection(with entertainments: [Media]){
        self.entertainments = entertainments
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func downloadMediaAt(_ indexpath: IndexPath ) {
        DataPersistenceManager.shared.downloadMediaWith(model: entertainments[indexpath.row]) { results in
            switch results {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationKey), object: nil)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    static let identifier = "HomeTableViewCell"
    
    weak var delegate: HomeTableViewCellDelegate?
    
    var entertainments: [Media] = [Media]()
    
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

