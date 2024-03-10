//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 10/03/2024.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureSearchController()
        configureTableView()
        configureTableDataSource()
        fetchFirstSearchContent()
        updateSearchTable(with: entertainments)
    }
    
    //MARK: - Configure Search Controller
    func configureSearchController(){
        let searchController = UISearchController(searchResultsController: self)
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.navigationItem.hidesSearchBarWhenScrolling = false

        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search shows, movies..."
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    //MARK: - Configure View Controller
    func configureTableView(){
        view.addSubview(searchTable)
        
        searchTable = UITableView(frame: view.bounds, style: .plain)
        searchTable.delegate = self
        searchTable.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
    }
    
    func configureTableDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Entertainment>(tableView: searchTable, cellProvider: { tableView, indexPath, entertainment -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell
            
            return cell
        })
    }
    
    //MARK: - Update UI content
    func fetchFirstSearchContent() {
        Task{
            do {
                let entertainments = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                self.entertainments = entertainments
                searchTable.reloadData()
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    func updateSearchTable(with entertainments: [Entertainment]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Entertainment>()
        snapShot.appendSections([.main])
        snapShot.appendItems(entertainments)
        DispatchQueue.main.async {self.dataSource.apply(snapShot, animatingDifferences: true)}
    }
    
    //MARK: - Declare UIElements
    var searchTable = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section, Entertainment>!

    var entertainments = [Entertainment]()
    var searchedEntertainments = [Entertainment]()
    var isStillSearching = false
    
    enum Section { case main }
}

extension SearchViewController: UITableViewDelegate,
                                UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    
}
