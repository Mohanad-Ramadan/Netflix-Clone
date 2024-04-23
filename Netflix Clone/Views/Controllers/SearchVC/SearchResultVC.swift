//
//  SearchResultVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/04/2024.
//

import UIKit

class SearchResultVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(resultTableView)
        resultTableView.frame = view.bounds
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
    }
    
    var resultTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionRowTableViewCell.self, forCellReuseIdentifier: CollectionRowTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.rowHeight = 180
        table.sectionHeaderTopPadding = 10
        table.sectionHeaderHeight = 15
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let sectionTitles :[String] = ["Top Results", "Action & Adventure" , "Crime & War", "Animation", "Family & Comedy"]
    
    var searchQuery: String? { didSet {resultTableView.reloadData()}}
    
}


//MARK: - SearchResults extension

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int { sectionTitles.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionRowTableViewCell.identifier, for: indexPath) as? CollectionRowTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        configureSearchResults(with: searchQuery ?? "", sections: indexPath.section, for: cell)
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
