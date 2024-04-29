//
//  MyListVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class MyListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        fetchMediaAt()
        updateVCContent()
    }
    
    private func configureVC(){
        view.backgroundColor = .black
        view.addSubview(downloadTable)
        downloadTable.frame = view.bounds
        downloadTable.delegate = self
        downloadTable.dataSource = self
        
        // Title name
        title = "My List"
    }
    
    private func updateVCContent() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.notificationKey), object: nil, queue: nil) { _ in
            self.fetchMediaAt()
        }
    }
    
    private func fetchMediaAt() {
        DataPersistenceManager.shared.fetchDownloadedMedias { [weak self] results in
            switch results {
            case .success(let media):
                self?.media = media
                self?.downloadTable.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private let downloadTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3)-8, height: 185)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var media: [MediaItem] = [MediaItem]()
    
}

extension MyListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let poster = media[indexPath.row].posterPath ?? ""
        cell.configureCell(with: poster)
        
        return cell
    }
    
    
}
