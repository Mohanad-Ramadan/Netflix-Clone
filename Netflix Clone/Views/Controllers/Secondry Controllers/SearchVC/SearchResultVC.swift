//
//  SearchResultVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/04/2024.
//

import UIKit
import SwiftUI

class SearchResultVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resultTableView)
        resultTableView.delegate = self
        resultTableView.dataSource = self
        configureLoadingSprinner()
        applyConstraints()
    }

    
    //MARK: - Apply constraitns
    func applyConstraints() {
        loadingSpinner.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingSpinner.view.topAnchor.constraint(equalTo: view.topAnchor, constant: -100),
            loadingSpinner.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingSpinner.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingSpinner.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
    
    //MARK: - setup LoadingSpinner
    func configureLoadingSprinner() {
        addChild(loadingSpinner)
        view.addSubview(loadingSpinner.view)
        loadingSpinner.didMove(toParent: self)
    }
    
    // delay removing loading view for better UX
    func finishLoading() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            UIView.animate {self.loadingSpinner.view.alpha = 0}
        }
    }
    
    //MARK: - Declare UIElements
    var resultTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionRowTableViewCell.self, forCellReuseIdentifier: CollectionRowTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.rowHeight = 180
        table.sectionHeaderTopPadding = 10
        table.sectionHeaderHeight = 15
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
        
    let loadingSpinner = UIHostingController(rootView: LoadingSpinnerView())
    
    let sectionTitles :[String] = ["Top Results", "Action & Adventure" , "Crime & War", "Animation", "Family & Comedy"]
    
    var searchQuery: String? {
        willSet {loadingSpinner.view.alpha = 1}
        didSet {resultTableView.reloadData()}
    }
    
}


//MARK: - SearchResults extension

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int { sectionTitles.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionRowTableViewCell.identifier, for: indexPath) as? CollectionRowTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        configureSearchResults(with: searchQuery ?? "", section: indexPath.section, for: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
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
    
}

//MARK: - CollectionRowTableViewCell Delegate
extension SearchResultVC : CollectionRowTableViewCell.Delegate {
    func collectionCellDidTapped(_ cell: CollectionRowTableViewCell, navigateTo vc: MediaDetailsVC) {
        presentAsRoot(vc)
    }
}
