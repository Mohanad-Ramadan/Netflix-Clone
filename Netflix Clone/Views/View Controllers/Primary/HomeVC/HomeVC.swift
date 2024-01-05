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
        
        configureNavbar()
        view.addSubview(homeFeedTable)
//        view.addSubview(skeletonLoadingView)
//        view.addSubview(categoryButtonsView)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.65))
        homeFeedTable.tableHeaderView = headerView
        
        
        homeBackground = HomeBackgroundUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        homeFeedTable.backgroundView = homeBackground

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        randomHeaderMovie()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        skeletonLoadingView.frame = view.bounds
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
    
    private func randomHeaderMovie(){
        APICaller.shared.getTrendingTV { [weak self] result in
            switch result {
            case .success(let movie):
                let randomMovie = movie.randomElement()
                self?.headerView?.configureHeaderPoster(with: MovieViewModel(title: randomMovie?.originalName ?? "Unknown", posterPath: randomMovie?.posterPath ?? "Unknown"))
                self?.homeBackground?.configureHeaderPoster(with: MovieViewModel(title: randomMovie?.originalName ?? "Unknown", posterPath: randomMovie?.posterPath ?? "Unknown"))
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//                    self?.skeletonLoadingView.removeFromSuperview()
//                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private let skeletonLoadingView = SkeletonLoadingUIView()
    
    private let categoryButtonsView = CategoryButtonsUIView()
    
    private var headerView: HeroHeaderUIView?
    
    private var homeBackground: HomeBackgroundUIView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    
    
    let sectionTitles :[String] = ["Top Series", "Trending Now" , "Popular Movies", "Trending Now", "Upcoming Movies"]
    
}




