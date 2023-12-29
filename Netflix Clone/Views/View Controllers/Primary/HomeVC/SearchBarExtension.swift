////
////  SearchBarExtension.swift
////  Netflix Clone
////
////  Created by Mohanad Ramdan on 04/12/2023.
////
//
//import UIKit
//
//
//extension HomeVC: SearchResultsVCDelegate ,UISearchResultsUpdating , UISearchControllerDelegate, UISearchBarDelegate {
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        
//        guard let query = searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty,
//              let resultController = searchController.searchResultsController as? SearchResultsVC else {return}
//        
//        resultController.delegate = self
//        
//        APICaller.shared.search(query: query) { results in
//            DispatchQueue.main.async {
//                switch results {
//                case .success(let entertainments):
//                    resultController.entertainments = entertainments
//                    resultController.searchResultCollectionView.reloadData()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//    
//    func searchResultsDidTapped(_ viewModel: MovieInfoViewModel) {
//        DispatchQueue.main.async { [weak self] in
//            let vc = MovieInfoVC()
//            vc.configureMovieInfo(with: viewModel)
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        
//        UIView.animate(withDuration: 0.3, animations: { [weak self] in
//            self?.navigationItem.searchController?.searchBar.alpha = 0.0
//        }) 
//        { [weak self] _ in
//            self?.navigationItem.searchController=nil
//        }
//    }
//    
//}
//navigationItem.searchController = searchController
//searchController.delegate = self
//searchController.searchResultsUpdater = self
//searchController.searchBar.delegate = self
//let searchController: UISearchController = {
//    let controller = UISearchController(searchResultsController: SearchResultsVC())
//    controller.searchBar.placeholder = "Search"
//    controller.searchBar.searchBarStyle = .minimal
//    return controller
//}()
