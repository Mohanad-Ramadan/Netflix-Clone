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
        fetchMediaAt()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.notificationKey), object: nil, queue: nil) { _ in
            self.fetchMediaAt()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        downloadTable.frame = view.bounds
    }
    
    private func configureNavBar(){
        navigationController?.navigationBar.tintColor = .white
        title = "Downloads"
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
    
    var media: [MediaItems] = [MediaItems]()
    
}

extension DownloadVC: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 180
    //    }
    //
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        switch editingStyle {
    //        case .delete:
    //
    //            DataPersistenceManager.shared.deleteMedias(model: media[indexPath.row]) { [weak self] results in
    //                switch results {
    //                case .success():
    //                    print("deleted")
    //                case .failure(let failure):
    //                    print(failure.localizedDescription)
    //                }
    //                self?.media.remove(at: indexPath.row)
    //                tableView.deleteRows(at: [indexPath], with: .fade)
    //            }
    //
    //        default:
    //            break
    //        }
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        collectionView.deselectItem(at: indexPath, animated: true)
    //
    //        let media = media[indexPath.row]
    //        guard let mediaName = media.title ?? media.originalName else {return}
    //
    //        NetworkManager.shared.getYoutubeTrailer(query: mediaName + " trailer") { [weak self] result in
    //            switch result {
    //            case .success(let videoElement):
    //                DispatchQueue.main.async { [weak self] in
    //                    let vc = MediaDetailsVC()
    //                    let viewModel = MovieInfoViewModel(title: mediaName, youtubeVideo: videoElement, titleOverview: media.overview ?? "Unknown")
    //
    //                    vc.configureVCDetails(with: viewModel )
    //
    //                    vc.hidesBottomBarWhenPushed = true
    //                    self?.navigationController?.present(vc, animated: true)
    //                }
    //            case .failure(let failure):
    //                print(failure.localizedDescription)
    //            }
    //        }
    //
    //    }
    
}
