//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeFeedTable)
        headerContainer.addSubview(categorySelectButtons)
        headerContainer.addSubview(heroHeaderView)
        homeFeedTable.tableHeaderView = headerContainer
        
        configureNavbar()
        randomHeader()
        applyConstriants()
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        homeBackground = HomeBackgroundUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        homeFeedTable.backgroundView = homeBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    @objc func searchButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(SearchVC(), animated: true)
        }
    }
    
    private func configureNavbar() {
        let userLabel = UILabel()
        userLabel.font = .boldSystemFont(ofSize: 26)
        userLabel.text = "For User1"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userLabel)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped)),
            UIBarButtonItem(image: UIImage(systemName: "airplayvideo"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func randomHeader(){
        APICaller.shared.getTrending {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    
                    guard let randomMovie = movie.randomElement() else { return }
                    
                    APICaller.shared.getImages(mediaType: randomMovie.mediaType ?? "movie", id: randomMovie.id) { result in
                        
                        switch result {
                        case .success(let fetchedImages):
                            // logo
                            let logoPath : String = {
                                let logos = fetchedImages.logos
                                if let englishLogo = logos.first(where: { $0.iso6391 == "en" }) {
                                    return englishLogo.filePath
                                } else if logos.isEmpty {
                                    return  ImageDetails(aspectRatio: 0, height: 0, filePath: "", voteAverage: 0.0, voteCount: 0, width: 0, iso6391: nil).filePath
                                } else {
                                    return logos[0].filePath
                                }
                            }()
                            
                            // backdrop
                            let backdrop = fetchedImages.backdrops.sorted(by: {$0.voteAverage>$1.voteAverage})[0]
                            let backdropPath = backdrop.filePath
                            
                            // configuration header
                            self.heroHeaderView.configureHeaderView(with: MovieViewModel(logoPath: logoPath, backdropsPath: backdropPath))
                            
                            // configuration background
                            self.homeBackground?.configureBackground(with: MovieViewModel(backdropsPath: backdropPath))
                            
                        case .failure(let failure):
                            print("Error getting images:", failure)
                            
                        }
                        
                    }
                    if randomMovie.mediaType == "movie" {
                        APICaller.shared.getDetails(mediaType: randomMovie.mediaType! , id: randomMovie.id) { (result: Result<MovieDetail, Error>) in
                            
                            switch result {
                            case .success(let fetchedDetials):
                                // detail
                                let detailCategory = fetchedDetials.seperateGenres(with: " • ")
                                
                                // configuration view
                                self.heroHeaderView.configureHeaderView(with: MovieViewModel(category: detailCategory ))
                            case .failure(let failure):
                                print(
                                    "Error getting details:",
                                    failure
                                )
                            }
                            
                        }
                    } else {
                        APICaller.shared.getDetails(mediaType: randomMovie.mediaType! , id: randomMovie.id) { (result: Result<TVDetail, Error>) in
                            switch result {
                            case .success(let fetchedDetials):
                                // detail
                                let detailCategory = fetchedDetials.seperateGenres(with: " • ")
                                
                                // configuration view
                                self.heroHeaderView.configureHeaderView(with: MovieViewModel(category: detailCategory ))
                            case .failure(let failure):
                                print(
                                    "Error getting details:",
                                    failure
                                )
                            }
                        }
                    }
                    
                    
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    private func applyConstriants() {
        // Apply constraints for categorySelectButtons
        categorySelectButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categorySelectButtons.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 3),
            categorySelectButtons.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 5),
            categorySelectButtons.widthAnchor.constraint(equalTo: headerContainer.widthAnchor),
            categorySelectButtons.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Apply constraints for headerView
        heroHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroHeaderView.topAnchor.constraint(equalTo: categorySelectButtons.bottomAnchor, constant: 25),
            heroHeaderView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            heroHeaderView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            heroHeaderView.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor)
        ])
    }
    
    private let headerContainer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height*(7/17), height: UIScreen.main.bounds.height/1.5 ))
    
    private let skeletonLoadingView = SkeletonLoadingUIView()
    
    private let categorySelectButtons = CategoryButtonsUIView()
    
    private var heroHeaderView = HeroHeaderUIView()
    
    private var homeBackground: HomeBackgroundUIView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let sectionTitles :[String] = ["Top Series", "Trending Now" , "Popular Movies", "Trending Now", "Upcoming Movies"]
    
}




