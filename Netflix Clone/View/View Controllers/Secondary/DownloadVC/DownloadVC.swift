//
//  DownloadViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class DownloadVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(downloadTable)
        
        downloadTable.delegate = self
        downloadTable.dataSource = self

        configureNavBar()
        fetchEntertainmentAt()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.notificationKey), object: nil, queue: nil) { _ in
            self.fetchEntertainmentAt()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        downloadTable.frame = view.bounds
    }
    
    @objc func searchButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(SearchVC(), animated: true)
        }
    }
    
    private func configureNavBar(){
        navigationController?.navigationItem.largeTitleDisplayMode = .inline
        navigationController?.navigationBar.tintColor = .white
        
        title = "Downloads"
    }
    
    private func fetchEntertainmentAt() {
        DataPersistenceManager.shared.fetchDownloadedEntertainments { [weak self] results in
            switch results {
            case .success(let entertainments):
                self?.entertainments = entertainments
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
    
    var entertainments: [EntertainmentItems] = [EntertainmentItems]()
    
}

