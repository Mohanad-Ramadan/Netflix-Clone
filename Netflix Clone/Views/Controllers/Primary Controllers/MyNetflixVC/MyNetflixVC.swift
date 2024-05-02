//
//  MyNetflixVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

class MyNetflixVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configureVC()
        applyConstraints()
        fetchDownloadedMedia()
        fetchTrailersWatched()
    }
    
    //MARK: - Configure VC
    private func configureVC() {
        view.backgroundColor = .black
        [profilImage,userLabel,userTable].forEach{view.addSubview($0)}
        
        userTable.delegate = self
        userTable.dataSource = self
    }
    
    
    private func configureNavbar() {
        let titleLabel = NFTitleLabel(text: "My Netflix")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        ]
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @objc func searchButtonTapped() {pushInMainThreadTo(SearchVC(), animated: false)}
    
    
    //MARK: - setup data for tables
    private func fetchDownloadedMedia() {
        // Notify the View to fetch the data agian
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.notificationKey), object: nil, queue: nil) { _ in
            self.fetchDownloadedMedia()
        }
        // Calling API request method
        PersistenceDataManager.shared.fetchMyListMedia { [weak self] results in
            switch results {
            case .success(let mediaItem):
                // transform MediaItem model to Media model
                let media: [Media] = {
                    let item = mediaItem.map { mediaItem in
                        Media(id: Int(mediaItem.id), originalName: mediaItem.originalName, title: mediaItem.title, overview: mediaItem.overview, mediaType: mediaItem.mediaType, posterPath: mediaItem.posterPath)
                    }
                    return item
                }()
                
                self?.myListMedia = media
                self?.userTable.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func fetchTrailersWatched() {
        // Notify the View to fetch the data agian
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.trailersKey), object: nil, queue: nil) { _ in
            self.fetchTrailersWatched()
        }
        // Calling API request method
        PersistenceDataManager.shared.fetchWatchedMedia() { [weak self] results in
            switch results {
            case .success(let watchedItem):
                // transform WatchedItem model to Media model
                let media: [Media] = {
                    let item = watchedItem.map { watchedItem in
                        Media(id: Int(watchedItem.id), originalName: watchedItem.originalName, title: watchedItem.title, overview: watchedItem.overview, mediaType: watchedItem.mediaType, posterPath: watchedItem.posterPath)
                    }
                    return item
                }()
                self?.watchedMedia = media
                self?.userTable.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    //MARK: - Constraints
    
    //Profil view
    private func profilImageConstraints() {
        profilImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profilImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    //User Label
    private func userLabelConstraints() {
        userLabel.topAnchor.constraint(equalTo: profilImage.bottomAnchor, constant: 5).isActive = true
        userLabel.centerXAnchor.constraint(equalTo: profilImage.centerXAnchor).isActive = true
        userLabel.widthAnchor.constraint(equalTo: userLabel.widthAnchor).isActive = true
        userLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func userTableConstraints() {
        userTable.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 20).isActive = true
        userTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        userTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        userTable.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    private func applyConstraints() {
        profilImageConstraints()
        userLabelConstraints()
        userTableConstraints()
    }
    
    //MARK: - setup section header
    func setupHeader(for section: Int) -> UIView {
        let headerView = UIView()
        if section == 0 { 
            headerView.addSubview(myListLabel)
            myListLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        } else {
            headerView.addSubview(watchedLabel)
            watchedLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        }
        return headerView
    }
    
    //MARK: - Declare UIElements
    private let userTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MyNetflixTableViewCell.self, forCellReuseIdentifier: MyNetflixTableViewCell.identifier)
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        table.sectionHeaderHeight = 25
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let myListLabel = NFBodyLabel(text: "My List", fontSize: 20, fontWeight: .bold)
    let watchedLabel = NFBodyLabel(text: "Trailers You've Watched", fontSize: 20, fontWeight: .bold)
    private let profilImage = NFImageView(image: .profil, cornerRadius: 10, contentMode: .scaleAspectFit)
    private let userLabel = NFPlainButton(title: "mohanad",image: UIImage(systemName: "chevron.down"), imagePlacement: .trailing, fontSize: 28, fontWeight: .bold)
    
    var myListMedia: [Media] = [Media]()
    var watchedMedia: [Media] = [Media]()
}
