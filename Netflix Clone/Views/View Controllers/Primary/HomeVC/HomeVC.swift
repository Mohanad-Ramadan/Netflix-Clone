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
        view.addSubview(categorySelectButtons)
        view.addSubview(headerView)
//        view.addSubview(homeFeedTable)
        applyConstraints()
        
//        view.addSubview(skeletonLoadingView)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        homeBackground = HomeBackgroundUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
//        homeFeedTable.backgroundView = homeBackground
        view.backgroundColor = .black

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        randomHeaderMovie()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        skeletonLoadingView.frame = view.bounds
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
                self?.headerView.configureHeaderPoster(with: MovieViewModel(title: randomMovie?.originalName ?? "Unknown", posterPath: randomMovie?.posterPath ?? "Unknown"))
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
    
    private let categorySelectButtons = CategoryButtonsUIView()
    
    private var headerView = HeroHeaderUIView()
    
    private var homeBackground: HomeBackgroundUIView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let sectionTitles :[String] = ["Top Series", "Trending Now" , "Popular Movies", "Trending Now", "Upcoming Movies"]
    
    
    //MARK: - Apply constraints
    private func categoryBarConstriants() {
        categorySelectButtons.translatesAutoresizingMaskIntoConstraints = false
        categorySelectButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3).isActive = true
        categorySelectButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        categorySelectButtons.widthAnchor.constraint(equalTo: categorySelectButtons.widthAnchor ).isActive = true
        categorySelectButtons.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    //User Label
    private func headerViewConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: categorySelectButtons.bottomAnchor, constant: 25).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: headerView.heightAnchor).isActive = true
    }
    
    //DownloadTable Title Row
    private func homefeedtableConstraints() {
        homeFeedTable.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        homeFeedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeFeedTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeFeedTable.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    private func applyConstraints() {
        categoryBarConstriants()
        headerViewConstraints()
//        homefeedtableConstraints()
    }
    
}




