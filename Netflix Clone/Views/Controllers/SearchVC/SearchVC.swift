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
        dataSource = UITableViewDiffableDataSource<Section, Media>(tableView: searchTable) { tableView, indexPath, media -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell
            configure(cell: cell, with: media)
            return cell
        }
        
        func configure(cell: SimpleTableViewCell? ,with media: Media){
            Task {
                do {
                    let mediaType = media.mediaType ?? "movie"
                    let id = media.id
                    let title = media.title ?? media.originalName
                    
                    let images = try await NetworkManager.shared.getImagesFor(mediaId: id ,ofType: mediaType)
                    let backdropPath = UIHelper.UIKit.getBackdropPathFrom(images)
                    cell?.configureCell(with: MovieViewModel(title: title ,backdropsPath: backdropPath))
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
                let media = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                self.media = media
                updateSearchTable(with: media)
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
                let fetchedMedia = try await NetworkManager.shared.getSearches(of: wantedMedia)
                searchedMedias = fetchedMedia
                updateSearchTable(with: searchedMedias)
            } catch let error as APIError {
                //                presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
                //                presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    func updateSearchTable(with media: [Media]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Media>()
        snapShot.appendSections([.main])
        
        if media == self.media {
            snapShot.appendItems(media)
            dataSource.apply(snapShot, animatingDifferences: false)
        } else {
            snapShot.appendItems(searchedMedias)
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
    
    var dataSource: UITableViewDiffableDataSource<Section, Media>!
    
    var media = [Media]()
    var searchedMedias = [Media]()
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

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            guard let desiredMedia = searchController.searchBar.text, !desiredMedia.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                self.updateSearchTable(with: self.media)
                self.isStillSearching = false
                return
            }
            self.isStillSearching = true
            self.fetchSearched(with: desiredMedia)
        }
    }
    
    
}
