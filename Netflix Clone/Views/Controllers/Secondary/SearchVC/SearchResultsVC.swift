//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 16/10/2023.
//

import UIKit

class SearchResultsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(searchResultTableView)
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultTableView.frame = view.bounds
    }
    
    
    public weak var delegate: SearchResultsVCDelegate?
    
    public let searchResultTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    var entertainments: [Entertainment] = [Entertainment]()
    

}


//MARK: - SearchResults extension

extension SearchResultsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as? SimpleTableViewCell else {
            return UITableViewCell()
        }
        
        let entertainment = entertainments[indexPath.row]
        
        let mediaType = entertainment.mediaType!
        let mediaId = entertainment.id
        let mediaTitle = entertainment.mediaType == "movie" ? entertainment.title : entertainment.originalName
        
        NetworkManager.shared.getImages(mediaType: mediaType, id: mediaId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedImages):
                    // backdrop
                    guard let backdrop = fetchedImages.backdrops.first,
                          !backdrop.filePath.isEmpty else { return }
                    let backdropPath = backdrop.filePath

                    // cell configuration
                    cell.configureCell(with: MovieViewModel(title: mediaTitle ,backdropsPath: backdropPath))
                case .failure(let failure):
                    print("Error getting images:", failure)
                }
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
//                    let viewModel = MovieInfoViewModel(title: entertainmentName, youtubeVideo: videoElement, titleOverview: entertainment.overview ?? "Unknown")
//                    
//                    self?.delegate?.searchResultsDidTapped(viewModel)
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//        
//    }

}

//MARK: - cellTapped method in protocol


protocol SearchResultsVCDelegate: AnyObject {
    func searchResultsDidTapped(_ viewModel: MovieViewModel)
}

