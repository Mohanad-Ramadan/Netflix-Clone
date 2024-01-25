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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = entertainments[indexPath.row]
        cell.configureTitlePoster(with: MovieViewModel(title: movie.title ?? "Unknown", posterPath: movie.posterPath ?? "Unknown"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entertainment = entertainments[indexPath.row]
        guard let entertainmentName = entertainment.title ?? entertainment.originalName else {return}
        
        
        APICaller.shared.getYoutubeTrailer(query: entertainmentName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async { [weak self] in
                    let vc = MovieInfoVC()
                    let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
                    
                    vc.configureMovieInfo(with: viewModel )
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
}


//MARK: - SearchResults extension

extension SearchVC: SearchResultsVCDelegate , UISearchResultsUpdating , UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultController = searchController.searchResultsController as? SearchResultsVC else {return}
        
        resultController.delegate = self
        
        APICaller.shared.search(query: query) { results in
            DispatchQueue.main.async {
                switch results {
                case .success(let entertainments):
                    // Filter the results to (Movie and TV) media type only
                    let rightResults :[Entertainment] = {
                        let result = entertainments
                        let filterResultsFormPersons = result.filter { $0.mediaType == "movie" || $0.mediaType == "tv" }
                        return filterResultsFormPersons
                    }()
                    
                    resultController.entertainments = rightResults
                    resultController.searchResultTableView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultsDidTapped(_ viewModel: MovieInfoViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MovieInfoVC()
            vc.configureMovieInfo(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}



