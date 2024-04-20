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
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultTableView.frame = view.bounds
    }
    
    private let resultTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionRowTableViewCell.self, forCellReuseIdentifier: CollectionRowTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    var entertainments: [Media] = [Media]()
    let sectionTitles :[String] = ["Top Series", "Trending Now" , "Popular Movies", "Trending Now", "Upcoming Movies"]
    
    weak var delegate: CollectionRowTableViewCell.Delegate?
}


//MARK: - SearchResults extension

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource{
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
    
}

//MARK: - CollectionRowTableViewCell Delegate
extension SearchResultVC : CollectionRowTableViewCell.Delegate {
    func collectionCellDidTapped(_ cell: CollectionRowTableViewCell, navigateTo vc: MediaDetailsVC) {
        presentAsRoot(vc)
    }
    
}