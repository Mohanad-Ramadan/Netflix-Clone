//
//  MyNetflixTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

class MyNetflixTableViewCell: UITableViewCell {
    
    protocol Delegate: AnyObject {func cellDidTapped(_ cell: MyNetflixTableViewCell, navigateTo vc: MediaDetailsVC)}
    
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
    
    
    public func configureCollection(with media: [MediaItems]){
        self.media = media
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
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
    
    weak var delegate: Delegate?
    var media: [MediaItems] = [MediaItems]()
    static let identifier = "MyNetflixTableViewCell"
    
    required init?(coder: NSCoder) {fatalError()}
}


