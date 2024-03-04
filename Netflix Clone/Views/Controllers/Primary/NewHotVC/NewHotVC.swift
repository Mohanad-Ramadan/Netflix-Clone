//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/10/2023.
//

import UIKit

class NewHotVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureView()
        handleUIAndDataFetching()
    }
    
    //MARK: - Configure UIElements
    private func configureVC(){
        configureNavbar()
        view.backgroundColor = .black
    }
    
    private func configureView(){
        view.addSubview(newAndHotTable)
        view.addSubview(categoryButtonsBar)
        view.addSubview(loadingView)
        
        loadingView.frame = view.bounds
        
        newAndHotTable.delegate = self
        newAndHotTable.dataSource = self
        
        applyConstriants()
    }
    
    private func configureNavbar() {
        let titleLabel = NFTitleLabel(text: "New & Hot")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }

    @objc func searchButtonTapped() {
        pushInMainThreadTo(SearchVC())
    }
    
    //MARK: - Apply constraints
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
    
    //MARK: - Declare UIElements
    var newAndHotTable: UITableView = {
        let table = UITableView()
        table.register(NewAndHotTableViewCell.self, forCellReuseIdentifier: NewAndHotTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let categoryButtonsBar = NewHotCategoryBarUIView()
    let loadingView = NewHotLoadingUIView()
    var entertainments: [Entertainment] = [Entertainment]()
    
    var isTheTappedEntertainmentTrend: Bool?
}

