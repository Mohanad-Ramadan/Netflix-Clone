//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureViews()
        setupHeaderAndBackground()
        setupHeroHeaderTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance.configureWithDefaultBackground()
    }
    
    //MARK: - Configure VC
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
    
    //MARK: - Constraints
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
    
    
    //MARK: - Declare Variables
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
    
    var heroHeaderMedia: Media?
    
    let sectionTitles :[String] = ["All Time Best TV Shows", "Trending Series" , "All Time Best Movies", "Trending Movies", "Upcoming Movies"]
}


//MARK: - TableView Delegate

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionRowTableViewCell.identifier, for: indexPath) as? CollectionRowTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        embedSections(sectionNumbs: indexPath.section, cell: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.sectionHeaderTopPadding = 10
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = NFBodyLabel(text: sectionTitles[section], color: .white, fontSize: 19, fontWeight: .bold)
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 9),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -5)
        ])
        
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffest = scrollView.contentOffset.y + (navigationController?.navigationBar.bounds.height)!
        let contentOffest = heroHeaderView.bounds.height
        let backgorundAlphaValue = max(0, min(1 - scrollOffest / contentOffest, 1.0))
        homeBackground.alpha = backgorundAlphaValue
    }
    
}

//MARK: - Cell Taped Delegate
extension HomeVC : CollectionRowTableViewCell.Delegate {
    func collectionCellDidTapped(_ cell: CollectionRowTableViewCell, navigateTo vc: MediaDetailsVC) {
        presentAsRoot(vc)
    }
    
}

//MARK: - Hero Header Delegate
extension HomeVC: HeroHeaderUIView.Delegate{
    func saveMediaToList() {presentTemporaryAlert(alertType: .save)}
    func removeMediafromList() {presentTemporaryAlert(alertType: .remove)}
    func finishLoadingPoster() {loadingView.removeFromSuperview()}
}




