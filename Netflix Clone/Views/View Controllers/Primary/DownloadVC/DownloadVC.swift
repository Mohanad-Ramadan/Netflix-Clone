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
        configureNavbar()
        downloadTable.delegate = self
        downloadTable.dataSource = self
        view.addSubview(downloadTable)
        fetchEntertainmentAt()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.notificationKey), object: nil, queue: nil) { _ in
            self.fetchEntertainmentAt()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        downloadTable.frame = view.bounds
    }
    
    private func configureNavbar() {
        let userLabel = UILabel()
        userLabel.font = .boldSystemFont(ofSize: 26)
        userLabel.text = "Download"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userLabel)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped)),
            UIBarButtonItem(image: UIImage(systemName: "airplayvideo"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc func searchButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(SearchVC(), animated: true)
        }
    }
    
    
    var entertainments: [EntertainmentItems] = [EntertainmentItems]()
    
    
    private let downloadTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        return table
    }()
    
    
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
    
}

