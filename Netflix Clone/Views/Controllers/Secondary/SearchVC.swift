//
//  SearchVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 10/03/2024.
//

import UIKit

class SearchVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureTableDataSource()
        fetchMediaAtFirstAppearnce()
    }
    
    //MARK: - Configure Search Controller
    func configureVC(){
        view.backgroundColor = .black
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search shows, movies..."
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.searchTextField.backgroundColor = .systemGray6
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
    }
    
    //MARK: - Configure Search table
    func configureTableView(){
        view.addSubview(searchTable)
        searchTable.delegate = self
        searchTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureTableDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Entertainment>(tableView: searchTable) { tableView, indexPath, entertainment -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell
            configure(cell: cell, with: entertainment)
            return cell
        }
        
        func configure(cell: SimpleTableViewCell? ,with entertainment: Entertainment){
            Task {
                do {
                    let images = try await NetworkManager.shared.getImagesFor(entertainmentId:entertainment.id ,ofType: entertainment.mediaType ?? "movie")
                    let backdropPath = UIHelper.getBackdropPathFrom(images)
                    cell?.configureCell(with: MovieViewModel(title: entertainment.title ,backdropsPath: backdropPath))
                } catch {
                    print("Error getting images:", error.localizedDescription)
                }
            }
        }
        
    }
    
    //MARK: - Update UI content
    func fetchMediaAtFirstAppearnce() {
        Task{
            do {
                let entertainments = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                self.entertainments = entertainments
                updateSearchTable(with: entertainments)
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSearched(with wantedMedia: String) {
        Task{
            do {
                let fetchedMedia = try await NetworkManager.shared.getSearches(about: wantedMedia)
                searchedEntertainments = fetchedMedia
                updateSearchTable(with: searchedEntertainments)
            } catch let error as APIError {
                //                presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
                //                presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    func updateSearchTable(with entertainments: [Entertainment]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Entertainment>()
        snapShot.appendSections([.main])
        
        if entertainments == self.entertainments {
            snapShot.appendItems(entertainments)
            dataSource.apply(snapShot, animatingDifferences: false)
        } else {
            snapShot.appendItems(searchedEntertainments)
            dataSource.apply(snapShot, animatingDifferences: true)
        }
        
    }
    
    //MARK: - Declare UIElements
    var searchTable: UITableView = {
        let table = UITableView()
        table.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        table.rowHeight = 100
        table.separatorStyle = .none
        return table
    }()
    
    var dataSource: UITableViewDiffableDataSource<Section, Entertainment>!
    
    var entertainments = [Entertainment]()
    var searchedEntertainments = [Entertainment]()
    var isStillSearching = false
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    }()
    
    enum Section { case main }
}

extension SearchVC: UITableViewDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let desiredMedia = searchController.searchBar.text, !desiredMedia.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            updateSearchTable(with: entertainments)
            isStillSearching = false
            return
        }
        
        isStillSearching = true
        fetchSearched(with: desiredMedia)
    }
    
    
}
