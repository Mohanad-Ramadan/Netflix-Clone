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
        homeFeedTable.backgroundView = homeBackground
        
        configureNavbar()
        fetchHeaderAndBackgound()
        applyConstriants()
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let boundsHeight = scrollView.bounds.height

        let blackLayerLocation = max(0, min(1 - offsetY / boundsHeight, 1.0))
        
        UIView.animate(withDuration: 10) {
            self.homeBackground.changeGradientLocations(to: blackLayerLocation)
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
    
    var heroHeaderView = HeroHeaderUIView()
    
    var homeBackground = HomeBackgroundUIView()
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let sectionTitles :[String] = ["Top Series", "Trending Now" , "Popular Movies", "Trending Now", "Upcoming Movies"]
    
}




