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
        view.backgroundColor = .black
        configureNavbar()
        configureViews()
        handleUIAndDataFetching()
        applyConstriants()
    }
    
    //MARK: - Configure UIElements
    private func configureViews(){
        view.addSubview(categoryButtonsBar)
        view.addSubview(scrollView)
        scrollView.addSubview(tablesStackView)
        [comingSoonTable, everybodyTable, topTVShowsTable, topMoviesTable].forEach{add(childTVC: $0, to: tablesStackView)}
    }
    
    private func add(childTVC: UITableViewController, to containerView: UIStackView) {
        addChild(childTVC)
        childTVC.view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        containerView.addArrangedSubview(childTVC.view)
        childTVC.didMove(toParent: self)
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
            categoryButtonsBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            categoryButtonsBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoryButtonsBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            categoryButtonsBar.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: categoryButtonsBar.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
        tablesStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        let scrollContentGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            tablesStackView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            tablesStackView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            tablesStackView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            tablesStackView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Declare UIElements
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let tablesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryButtonsBar = NewHotCategoryBarUIView()
    
    let comingSoonTable: UITableViewController = ComingSoonTVC()
    
    let everybodyTable: UITableViewController = EverybodyTVC()
    
    let topMoviesTable: UITableViewController = TopMoviesTVC()
    
    let topTVShowsTable: UITableViewController = TopTVShowsTVC()
}

