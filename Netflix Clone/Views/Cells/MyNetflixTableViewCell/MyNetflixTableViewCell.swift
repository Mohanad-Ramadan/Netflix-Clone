//
//  MyNetflixTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit
import SkeletonView


protocol MyNetflixTableViewCellDelegate: AnyObject {
    func myNetflixTableViewCellDidTapped(_ cell: MyNetflixTableViewCell, navigateTo vc: EntertainmentDetailsVC)
}

class MyNetflixTableViewCell: UITableViewCell {
    
    static let identifier = "MyNetflixTableViewCell"
    
    weak var delegate: MyNetflixTableViewCellDelegate?
    
    var entertainments: [EntertainmentItems] = [EntertainmentItems]()
    
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
    
    
    public func configureCollection(with entertainments: [EntertainmentItems]){
        self.entertainments = entertainments
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:\(coder) has not been implemented")
    }
}


