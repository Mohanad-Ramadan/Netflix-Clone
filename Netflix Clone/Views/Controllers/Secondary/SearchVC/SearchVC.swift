//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class SearchVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(searchTable)
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.hidesBackButton = true
        navigationItem.titleView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        return table
    }()
    
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsVC())
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.showsCancelButton = true
        return controller
    }()
    
    
    var entertainments: [Entertainment] = [Entertainment]()
    
}


