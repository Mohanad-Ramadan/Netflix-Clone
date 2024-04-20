//
//  SearchVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 10/03/2024.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchMediaAtFirstAppearnce()
    }
    
    //MARK: - Configure Search Controller
    func configureSearchController(){
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
        // customize the action for barbackButton
        navigationItem.backAction = UIAction() { _ in
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: - Configure Search table
    func configureTableView(){
        // configure TablView
        view.addSubview(searchTable)
        searchTable.delegate = self
        searchTable.dataSource = self
        
        // configure header
        let headerTitle = NFPlainButton(title: "Recommended TV Shows & Movies", fontSize: 20, fontWeight: .bold)
        searchTable.tableHeaderView = headerTitle
        
        // apply constraints
        NSLayoutConstraint.activate([
            searchTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: - Update UI content
    func fetchMediaAtFirstAppearnce() {
        Task{
            do {
                let media = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                self.media = media
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
    
    //MARK: - Declare UIElements
    var searchTable: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.rowHeight = 100
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
            
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultVC())
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    }()
    
    
    var media = [Media]()
}

//MARK: - SearchTableView Delegats
extension SearchVC: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { media.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let media = media[indexPath.row]
        cell.configure(with: media)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let media = media[indexPath.row]
        if media.mediaType == nil || media.mediaType == "movie" {
            let vc = MovieDetailsVC(for: media)
            presentAsRoot(vc)
        } else {
            let vc = TVDetailsVC(for: media)
            presentAsRoot(vc)
        }
    }
    
}

//MARK: - SearchResult Delegats
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
//            guard let desiredMedia = searchController.searchBar.text, !desiredMedia.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//                self.updateSearchTable(with: self.media)
//                self.isStillSearching = false
//                return
//            }
//            self.isStillSearching = true
//            self.fetchSearched(with: desiredMedia)
//        }
    }
    
    
}
