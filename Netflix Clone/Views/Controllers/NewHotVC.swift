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
        applyConstriants()
    }
    
    //MARK: - Configure UIElements
    private func configureViews(){
        [comingSoonTable, everybodyTable, topTVShowsTable, topMoviesTable].forEach{add(childTVC: $0, to: tablesStackView)}
        scrollView.addSubview(tablesStackView)
        view.addSubview(scrollView)
        view.addSubview(categoryButtonsBar)
        
        categoryButtonsBar.delegate = self
        scrollView.delegate = self
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
    
    let comingSoonTable = ComingSoonTVC()
    let everybodyTable = EverybodyTVC()
    let topMoviesTable = TopMoviesTVC()
    let topTVShowsTable = TopTVShowsTVC()
}


//MARK: - Categroy Bar Delegate
extension NewHotVC: NewHotCategoryBarUIView.Delegate {
    func buttonPressed(buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            comingSoonTable.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            categoryButtonsBar.animateButton(atIndex: 0)
            
        case 1:
            everybodyTable.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
            categoryButtonsBar.animateButton(atIndex: 1)
            
        case 2:
            topTVShowsTable.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            scrollView.setContentOffset(CGPoint(x: 2 * scrollView.bounds.width, y: 0), animated: false)
            categoryButtonsBar.animateButton(atIndex: 2)
            
        case 3:
            topMoviesTable.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            scrollView.setContentOffset(CGPoint(x: 3 * scrollView.bounds.width, y: 0), animated: false)
            categoryButtonsBar.animateButton(atIndex: 3)
            
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
        case 0...firstOffestTriger: categoryButtonsBar.animateButton(atIndex: 0)
        case firstOffestTriger...secondOffestTriger: categoryButtonsBar.animateButton(atIndex: 1)
        case secondOffestTriger...thirdOffestTriger: categoryButtonsBar.animateButton(atIndex: 2)
        case thirdOffestTriger...forthOffestTriger: categoryButtonsBar.animateButton(atIndex: 3)
        default: break
        }

    }
}
