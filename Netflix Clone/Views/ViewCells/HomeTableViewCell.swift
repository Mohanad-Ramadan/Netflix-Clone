//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit
import SkeletonView


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
    
    
    public func configureCollection(with entertainments: [Entertainment]){
        self.entertainments = entertainments
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadEntertainmentAt(_ indexpath: IndexPath ) {
        DataPersistenceManager.shared.downloadEntertainmentWith(model: entertainments[indexpath.row]) { results in
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
    
    private var entertainments: [Entertainment] = [Entertainment]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 115, height: 170)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:\(coder) has not been implemented")
    }
}


//MARK: - HomeTableViewCell extensions

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        let poster = entertainments[indexPath.row].posterPath ?? ""
        cell.configureTitle(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let entertainment = entertainments[indexPath.row]
        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
        
        APICaller.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let entertainment = self?.entertainments[indexPath.row]
                guard let movieOverview = entertainment?.overview else {
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: movieOverview)
                self?.delegate?.homeTableViewCellDidTapped(strongSelf, viewModel: viewModel)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadEntertainmentAt(indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
        
    }
    
}

//MARK: - cellTapped method in protocol 

protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCellDidTapped(_ cell: HomeTableViewCell, viewModel: MovieInfoViewModel)
}

//MARK: - CellTapedAction extension

extension HomeVC :HomeTableViewCellDelegate {
    func homeTableViewCellDidTapped(_ cell: HomeTableViewCell, viewModel: MovieInfoViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = MovieInfoVC()
            vc.configureMovieInfo(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
