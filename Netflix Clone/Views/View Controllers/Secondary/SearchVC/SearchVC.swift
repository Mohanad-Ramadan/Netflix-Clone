//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class SearchVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(searchTable)
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        navigationController?.navigationBar.tintColor = .secondaryLabel
        
        navigationItem.titleView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    
    
    private func fetchDiscoverdMovies(){
        APICaller.shared.getDiscoverdMovies { [weak self] results in
            switch results {
            case .success(let entertainments):
                self?.entertainments = entertainments
                DispatchQueue.main.async { [weak self] in
                    self?.searchTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        return table
    }()
    
    
    var entertainments: [Entertainment] = [Entertainment]()
    
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsVC())
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.showsCancelButton = true
        return controller
    }()
    
    
}


