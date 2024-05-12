//
//  CategoryVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit

class CategoryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        [tableView,loadingView].forEach {view.addSubview($0)}
        configureVC()
        configureTableHeader()
        fetchMedia()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        loadingView.frame = view.bounds
    }
    
    //MARK: - Setup VC
    func configureVC() {}
    
    func configureTableHeader() {}
    
    func fetchMedia() {}
    
    func removeLoadingView() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.loadingView.alpha = 0
        }
    }
    
    //MARK: - Declare Variables
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let loadingView = NewHotLoadingUIView()
    
    var media: [Media] = [Media]()
}

//MARK: - Cell Delegate
extension CategoryVC: NewHotTableViewCell.Delegate {
    func saveMediaToList() {presentTemporaryAlert(alertType: .save)}
    func removeMediafromList() {presentTemporaryAlert(alertType: .remove)}
}
