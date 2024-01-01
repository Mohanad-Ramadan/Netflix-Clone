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
        configureNavbar()
        view.addSubview(newAndHotTable)
        
        newAndHotTable.delegate = self
        newAndHotTable.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newAndHotTable.frame = view.bounds
    }
    
    private func configureNavbar() {
        let viewTitle = UILabel()
        viewTitle.font = .boldSystemFont(ofSize: 26)
        viewTitle.text = "New & Hot"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped)),
            UIBarButtonItem(image: UIImage(systemName: "airplayvideo"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc func searchButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(SearchVC(), animated: true)
        }
    }
    
    private let newAndHotTable: UITableView = {
        let table = UITableView()
        table.register(NewAndHotTableViewCell.self, forCellReuseIdentifier: NewAndHotTableViewCell.identifier)
        return table
    }()
    
    var entertainments: [Entertainment] = [Entertainment]()
    
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
    
}

