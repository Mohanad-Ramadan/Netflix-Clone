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
        title = "New & Hot"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(newAndHotTable)
        
        newAndHotTable.delegate = self
        newAndHotTable.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newAndHotTable.frame = view.bounds
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


// MARK: - Preview

#Preview("NewAndHotVC", traits: .defaultLayout, body: {
    NewAndHotVC()
})
