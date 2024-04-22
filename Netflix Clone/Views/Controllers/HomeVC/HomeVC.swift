//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureViews()
        setupHeaderAndBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance.configureWithDefaultBackground()
    }
    
    //MARK: - Configure UIElements
    private func configureVC() {
        configureNavbar()
        
        view.addSubview(homeFeedTable)
        homeFeedTable.frame = view.bounds
        
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
    }
    
    private func configureViews() {
        // Add subviews
        headerContainer.addSubview(categorySelectButtons)
        headerContainer.addSubview(heroHeaderView)
        
        homeFeedTable.tableHeaderView = headerContainer
        homeFeedTable.backgroundView = homeBackground
        
        // configure delagtes
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        heroHeaderView.delegate = self
        
        // configure UIElements
        applyConstriants()
    }
    
    private func configureNavbar() {
        let titleLabel = NFTitleLabel(text: "For mohanad")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @objc func searchButtonTapped() {pushInMainThreadTo(SearchVC(), animated: false)}
    
    //MARK: - Apply constraints
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
    
    
    //MARK: - Declare UIElements
    private let headerContainer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height*(7/17), height: UIScreen.main.bounds.height/1.40 ))
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionRowTableViewCell.self, forCellReuseIdentifier: CollectionRowTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let categorySelectButtons = HomeCategoryBarUIView()
    var heroHeaderView = HeroHeaderUIView()
    var homeBackground = HomeBackgroundUIView()
    let loadingView = HomeLoadingUIView()
    
    let sectionTitles :[String] = ["Top Series", "Trending Now" , "Popular Movies", "Trending Now", "Upcoming Movies"]
}




