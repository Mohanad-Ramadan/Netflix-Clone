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
        DataPersistenceManager.shared.fetchDownloadedMedias { [weak self] results in
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
        DataPersistenceManager.shared.fetchWatchedMedias() { [weak self] results in
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
    
    func setupSectionsHeader(for superView: UIView ,withHeader headerview: UIView) {
        superView.addSubview(headerview)
        headerview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerview.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 5),
            headerview.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            headerview.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: -15)
        ])
    }
    
    //MARK: - Declare UIElements
    private let userTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MyNetflixTableViewCell.self, forCellReuseIdentifier: MyNetflixTableViewCell.identifier)
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let myListRow: CustomRowUIView = CustomRowUIView(title: "My List")
    let watchedTrailerRow: CustomRowUIView = CustomRowUIView(title: "Trailers You've Watched")
    private let profilImage = NFImageView(image: .profil, cornerRadius: 10, contentMode: .scaleAspectFit)
    private let userLabel = NFPlainButton(title: "mohanad",image: UIImage(systemName: "chevron.down"), imagePlacement: .trailing, fontSize: 28, fontWeight: .bold)
    
    var myListMedia: [Media] = [Media]()
    var watchedMedia: [Media] = [Media]()
}
