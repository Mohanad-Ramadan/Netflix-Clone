//
//  MyNetflixExtension.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import UIKit

//MARK: - HomeVC Extensions

extension MyNetflixVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyNetflixTableViewCell.identifier, for: indexPath) as? MyNetflixTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        if indexPath.section == 0 { cell.configureCollection(with: myListMedia, isListSection: true) }
        else if indexPath.section == 1 {  cell.configureCollection(with: watchedMedia, isListSection: false) }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupHeader(for: section)
    }
    
}


//MARK: - CellTapedAction extension

extension MyNetflixVC :MyNetflixTableViewCell.Delegate {
    func cellDidTapped(_ cell: MyNetflixTableViewCell, navigateTo vc: MediaDetailsVC) {
        presentAsRoot(vc)
    }
}
