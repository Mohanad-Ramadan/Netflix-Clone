//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class NewAndHotVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(newAndHotTable)
        newAndHotTable.tableHeaderView = categoryButtonsBar
        
        newAndHotTable.delegate = self
        newAndHotTable.dataSource = self
        
        configureNavbar()
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newAndHotTable.frame = view.bounds
        categoryButtonsBar.frame = CGRect(x: 0, y: 0, width: categoryButtonsBar.bounds.width, height: 70)
    }
    
    @objc func searchButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(SearchVC(), animated: true)
        }
    }
    
    private func configureNavbar() {
        let viewTitle = UILabel()
        viewTitle.font = .boldSystemFont(ofSize: 26)
        viewTitle.text = "New & Hot"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func fetchUpcoming(){
        APICaller.shared.getTrendingMovies { [weak self] results in
            switch results {
            case .success(let entertainments):
                self?.entertainments = entertainments
                DispatchQueue.main.async { [weak self] in
                    self?.newAndHotTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private let newAndHotTable: UITableView = {
        let table = UITableView()
        table.register(NewAndHotTableViewCell.self, forCellReuseIdentifier: NewAndHotTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let categoryButtonsBar = NewHotCategoryBarUIView()
    
    var entertainments: [Entertainment] = [Entertainment]()

    
}

