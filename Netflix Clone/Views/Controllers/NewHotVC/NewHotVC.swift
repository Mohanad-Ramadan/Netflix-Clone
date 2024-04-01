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
        view.addSubview(comingSoonTable)
        view.addSubview(categoryButtonsBar)
        
        comingSoonTable.delegate = self
        comingSoonTable.dataSource = self
        applyConstriants()
    }
    
    private func configureNavbar() {
        let titleLabel = NFTitleLabel(text: "New & Hot")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    @objc func searchButtonTapped() {pushInMainThreadTo(SearchVC())}
    
    //MARK: - Apply constraints
    private func applyConstriants() {
        categoryButtonsBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryButtonsBar.topAnchor.constraint(equalTo: view.topAnchor),
            categoryButtonsBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoryButtonsBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            categoryButtonsBar.heightAnchor.constraint(equalToConstant: 70),
            
            comingSoonTable.topAnchor.constraint(equalTo: categoryButtonsBar.bottomAnchor),
            comingSoonTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            comingSoonTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            comingSoonTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: - Declare UIElements
    var comingSoonTable: UITableView = {
        let table = UITableView()
        table.register(NewHotTableViewCell.self, forCellReuseIdentifier: NewHotTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let categoryButtonsBar = NewHotCategoryBarUIView()
    var media: [Media] = [Media]()
    
    var isTheTappedMediaTrend: Bool?
}

