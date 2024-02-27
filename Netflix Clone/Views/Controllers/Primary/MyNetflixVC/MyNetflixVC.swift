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
        view.backgroundColor = .black
        
        view.addSubview(downloadTable)
        view.addSubview(profilImage)
        view.addSubview(userLabel)
        view.addSubview(downloadTitleRow)
        
        downloadTable.delegate = self
        downloadTable.dataSource = self
        
        applyConstraints()
        
        fetchDownloadedEntertainment()
        
    }
    
    @objc func searchButtonTapped() {
        pushInMainThreadTo(SearchVC())
    }
    
    private func configureNavbar() {
        let userLabel = UILabel()
        userLabel.font = .boldSystemFont(ofSize: 26)
        userLabel.text = "My Netflix"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userLabel)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func fetchDownloadedEntertainment() {
        // Notify the View to fetch the data agian
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.notificationKey), object: nil, queue: nil) { _ in
            self.fetchDownloadedEntertainment()
        }
        // Calling API request method
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
    
    //DownloadTable Title Row
    private func downloadTitleRowConstraints() {
        downloadTitleRow.translatesAutoresizingMaskIntoConstraints = false
        downloadTitleRow.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 20).isActive = true
        downloadTitleRow.heightAnchor.constraint(equalToConstant: 40).isActive = true
        downloadTitleRow.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        downloadTitleRow.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //Download Table Label
    private func downloadTableConstraints() {
        downloadTable.topAnchor.constraint(equalTo: downloadTitleRow.bottomAnchor, constant: 20).isActive = true
        downloadTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        downloadTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        downloadTable.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func applyConstraints() {
        profilImageConstraints()
        userLabelConstraints()
        downloadTitleRowConstraints()
        downloadTableConstraints()
    }
    
    private let profilImage = NFImageView(image: .profil, cornerRadius: 10, contentMode: .scaleAspectFit)
        
    private let userLabel: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled() 
        configuration.title = "User1"
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "chevron.down")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 28, weight: .bold)
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let downloadTitleRow: MyNetflixRowUIView = MyNetflixRowUIView()
    
    private let downloadTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(MyNetflixTableViewCell.self, forCellReuseIdentifier: MyNetflixTableViewCell.identifier)
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var entertainments: [EntertainmentItems] = [EntertainmentItems]()
    

}
