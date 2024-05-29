//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import UIKit

class NewHotVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureNavbar()
        configureViews()
        applyConstriants()
    }
    
    //MARK: - Configure UIElements
    private func configureViews(){
        view.addSubview(categoryButtonsBar)
        view.addSubview(scrollView)
        [comingSoonTable, everyonesTable, topTVShowsTable, topMoviesTable].forEach{add(childVC: $0, to: tablesStackView)}
        scrollView.addSubview(tablesStackView)
        
        categoryButtonsBar.delegate = self
        scrollView.delegate = self
    }
    
    private func add(childVC: UIViewController, to containerView: UIStackView) {
        addChild(childVC)
        childVC.view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        containerView.addArrangedSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    private func configureNavbar() {
        let titleLabel = NFTitleLabel(text: "New & Hot")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.backButtonDisplayMode = .minimal
    }

    @objc func searchButtonTapped() {pushInMainThreadTo(SearchVC(), animated: false)}
    
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
            tablesStackView.topAnchor.constraint(equalTo: categoryButtonsBar.bottomAnchor),
            tablesStackView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            tablesStackView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            tablesStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Declare UIElements
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
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
    let comingSoonTable = ComingSoonVC()
    let everyonesTable = EverybodyVC()
    let topMoviesTable = TopMoviesVC()
    let topTVShowsTable = TopTVShowsVC()
}


//MARK: - Categroy Bar Delegate
extension NewHotVC: NewHotCategoryBarUIView.Delegate {
    func buttonPressed(buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            categoryButtonsBar.animateButton(atIndex: 0)
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            comingSoonTable.tableView.setContentOffset(.zero, animated: true)
            
        case 1:
            everyonesTable.fetchMedia()
            categoryButtonsBar.animateButton(atIndex: 1)
            scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
            everyonesTable.tableView.setContentOffset(.zero, animated: true)
            
        case 2:
            topTVShowsTable.fetchMedia()
            categoryButtonsBar.animateButton(atIndex: 2)
            scrollView.setContentOffset(CGPoint(x: 2 * scrollView.bounds.width, y: 0), animated: false)
            topTVShowsTable.tableView.setContentOffset(.zero, animated: true)
            
        case 3:
            topMoviesTable.fetchMedia()
            categoryButtonsBar.animateButton(atIndex: 3)
            scrollView.setContentOffset(CGPoint(x: 3 * scrollView.bounds.width, y: 0), animated: false)
            topMoviesTable.tableView.setContentOffset(.zero, animated: true)
            
        default: break
        }
    }
}


//MARK: - ScrollView Delegate
extension NewHotVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let tableWidth = view.bounds.width
        
        // offests triggers the paging feature to next tableView
        let firstOffestTriger = tableWidth/2
        let secondOffestTriger = firstOffestTriger + tableWidth
        let thirdOffestTriger = secondOffestTriger + tableWidth
        let forthOffestTriger = thirdOffestTriger + tableWidth
        
        switch offset {
        case 0...firstOffestTriger: 
            categoryButtonsBar.animateButton(atIndex: 0)
            everyonesTable.fetchMedia()
        case firstOffestTriger...secondOffestTriger: 
            categoryButtonsBar.animateButton(atIndex: 1)
            topTVShowsTable.fetchMedia()
        case secondOffestTriger...thirdOffestTriger: 
            categoryButtonsBar.animateButton(atIndex: 2)
            topMoviesTable.fetchMedia()
        case thirdOffestTriger...forthOffestTriger: 
            categoryButtonsBar.animateButton(atIndex: 3)
        default: break
        }

    }
}
