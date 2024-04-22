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
        configureSubviews()
        screenFirstAppearnce()
    }
    
    //MARK: - Configure VC
    func configureVC() {
        view.backgroundColor = .black
        // configure navigation
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.titleView = searchBar
        navigationItem.backAction = UIAction() { _ in
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: - Configure Search table
    func configureSubviews(){
        // configure subviews
        view.addSubview(searchTable)
        searchTable.frame = view.bounds
        searchTable.delegate = self
        searchTable.dataSource = self
        // configure searchesultsVC
        setupSearchResultsVC()
        
        // configure header
        let headerTitle = NFPlainButton(title: "Recommended TV Shows & Movies", fontSize: 20, fontWeight: .bold)
        searchTable.tableHeaderView = headerTitle
    }
    
    func setupSearchResultsVC() {
        addChild(searchResultsVC)
        searchResultsVC.view.frame = searchTable.bounds
        view.addSubview(searchResultsVC.view)
        searchResultsVC.didMove(toParent: self)
    }
    
    func screenFirstAppearnce() {
        // show recommended first
        searchTable.alpha = 1
        searchResultsVC.view.alpha = 0
        // fetch recommended media
        fetchRecommendedMedia()
    }
    
    func fetchRecommendedMedia() {
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
    let searchResultsVC = SearchResultVC()
    
    var searchTable: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.rowHeight = 100
        table.separatorStyle = .none
        return table
    }()
            
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    }()
    
    
    lazy var searchBar: UISearchBar = {
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search shows, movies..."
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.searchTextField.backgroundColor = .systemGray6
        searchBar.sizeToFit()
        return searchBar
    }()
    
    var media = [Media]()
}

//MARK: - SearchTableView Delegats
extension SearchVC:  UITableViewDelegate, UITableViewDataSource {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            guard let desiredMedia = searchController.searchBar.text, !desiredMedia.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                self.searchResultsVC.view.alpha = 0
                self.searchTable.alpha = 1
                return
            }
            self.searchResultsVC.view.alpha = 1
            self.searchTable.alpha = 0
            
        }
    }
    
}

