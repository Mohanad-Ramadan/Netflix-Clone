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
    }
    
    //MARK: - Configure VC
    private func configureVC() {
        view.backgroundColor = .black
        [profilImage,userLabel,myListRow,myListTable, watchedTrailerRow, watchedTrailersTable].forEach{view.addSubview($0)}
        
        myListTable.delegate = self
        myListTable.dataSource = self
        
        watchedTrailersTable.delegate = self
        watchedTrailersTable.dataSource = self
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
            case .success(let media):
                self?.media = media
                self?.myListTable.reloadData()
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
        DataPersistenceManager.shared.fetchDownloadedMedias { [weak self] results in
            switch results {
            case .success(let media):
                self?.watchedMedia = media
                self?.watchedTrailersTable.reloadData()
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
    
    //My List Row
    private func myListRowConstraints() {
        myListRow.translatesAutoresizingMaskIntoConstraints = false
        myListRow.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 20).isActive = true
        myListRow.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myListRow.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myListRow.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func myListTableConstraints() {
        myListTable.topAnchor.constraint(equalTo: myListRow.bottomAnchor).isActive = true
        myListTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myListTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myListTable.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // Trailers watched Row
    private func watchedTrailersRowConstraints() {
        watchedTrailerRow.translatesAutoresizingMaskIntoConstraints = false
        watchedTrailerRow.topAnchor.constraint(equalTo: myListTable.bottomAnchor, constant: 20).isActive = true
        watchedTrailerRow.heightAnchor.constraint(equalToConstant: 40).isActive = true
        watchedTrailerRow.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        watchedTrailerRow.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //Download Table Label
    private func watchedTrailersTableConstraints() {
        watchedTrailersTable.topAnchor.constraint(equalTo: watchedTrailerRow.bottomAnchor).isActive = true
        watchedTrailersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        watchedTrailersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        watchedTrailersTable.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func applyConstraints() {
        profilImageConstraints()
        userLabelConstraints()
        myListRowConstraints()
        myListTableConstraints()
        watchedTrailersRowConstraints()
        watchedTrailersTableConstraints()
    }
    
    //MARK: - Declare UIElements
    private let myListTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(MyNetflixTableViewCell.self, forCellReuseIdentifier: MyNetflixTableViewCell.identifier)
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let watchedTrailersTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(MyNetflixTableViewCell.self, forCellReuseIdentifier: MyNetflixTableViewCell.identifier)
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let myListRow: CustomRowUIView = CustomRowUIView(title: "My List")
    private let watchedTrailerRow: CustomRowUIView = CustomRowUIView(title: "Trailers You've Watched")
    private let profilImage = NFImageView(image: .profil, cornerRadius: 10, contentMode: .scaleAspectFit)
    private let userLabel = NFPlainButton(title: "mohanad",image: UIImage(systemName: "chevron.down"), imagePlacement: .trailing, fontSize: 28, fontWeight: .bold)
    
    var media: [MediaItems] = [MediaItems]()
    var watchedMedia: [MediaItems] = [MediaItems]()
}
