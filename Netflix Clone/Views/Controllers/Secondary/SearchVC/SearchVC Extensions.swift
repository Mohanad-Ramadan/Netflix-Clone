//
//  SearchVC Extensions.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 05/12/2023.
//

import UIKit

//MARK: - SearchTableView extension

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell else {return UITableViewCell()}
        
        let entertainment = entertainments[indexPath.row]
        
        let mediaTitle = entertainment.mediaType == "movie" ? entertainment.title : entertainment.originalName
        
        Task {
            do {
                let images = try await NetworkManager.shared.getImagesFor(entertainmentId:entertainment.id ,ofType: entertainment.mediaType!)
                let backdropPath = UIHelper.getBackdropPathFrom(images)
                cell.configureCell(with: MovieViewModel(title: mediaTitle ,backdropsPath: backdropPath))
            } catch {
                print("Error getting images:", error.localizedDescription)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        let entertainment = entertainments[indexPath.row]
//        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
//        
//        
//        NetworkManager.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async { [weak self] in
//                    let vc = EntertainmentDetailsVC()
//                    let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
//                    
//                    vc.configureVCDetails(with: viewModel )
//                    
//                    vc.hidesBottomBarWhenPushed = true
//                    self?.navigationController?.present(vc, animated: true)
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//        
//    }
    
}


//MARK: - SearchResults extension

extension SearchVC: SearchResultsVCDelegate , UISearchResultsUpdating , UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultController = searchController.searchResultsController as? SearchResultsVC else {return}
        resultController.delegate = self
        
        Task {
            do {
                let searchResults = try await NetworkManager.shared.fetchSearchsOf(query)
                resultController.entertainments = UIHelper.removePersonsFrom(searchResults)
                resultController.searchResultTableView.reloadData()
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    func searchResultsDidTapped(_ viewModel: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = EntertainmentDetailsVC()
            vc.configureVCDetails(with: viewModel)
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.present(vc, animated: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}



