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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyNetflixTableViewCell.identifier, for: indexPath) as? MyNetflixTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configureCollection(with: entertainments)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}


//MARK: - CellTapedAction extension

extension MyNetflixVC :MyNetflixTableViewCellDelegate {
    func myNetflixTableViewCellDidTapped(_ cell: MyNetflixTableViewCell, viewModel: MovieViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = EntertainmentDetailsVC()
            vc.configureDetails(with: viewModel)
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.present(vc, animated: true)
        }
    }
}
