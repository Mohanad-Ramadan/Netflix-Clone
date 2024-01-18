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
        view.addSubview(categoryButtonsBar)
        
        newAndHotTable.delegate = self
        newAndHotTable.dataSource = self
        
        applyConstriants()
        configureNavbar()
        fetchUpcoming()
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
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let categoryButtonsBar = NewHotCategoryBarUIView()
    
    var entertainments: [Entertainment] = [Entertainment]()

    private func applyConstriants() {
        // Apply constraints for categorySelectButtons
        categoryButtonsBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryButtonsBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryButtonsBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoryButtonsBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            categoryButtonsBar.heightAnchor.constraint(equalToConstant: 70 )
        ])
        NSLayoutConstraint.activate([
            newAndHotTable.topAnchor.constraint(equalTo: categoryButtonsBar.bottomAnchor),
            newAndHotTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            newAndHotTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            newAndHotTable.bottomAnchor.constraint(equalTo: view.bottomAnchor )
        ])
        
    }
}

