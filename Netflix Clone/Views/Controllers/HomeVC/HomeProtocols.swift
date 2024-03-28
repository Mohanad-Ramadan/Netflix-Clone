//
//  HomeProtocols.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/12/2023.
//

import UIKit

//MARK: - HomeVC Extensions

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        embedSections(sectionNumbs: indexPath.section, cell: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.sectionHeaderTopPadding = 10
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = NFBodyLabel(text: sectionTitles[section], color: .white, fontSize: 19, fontWeight: .bold)
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 9),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -5)
        ])
        
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffest = scrollView.contentOffset.y + (navigationController?.navigationBar.bounds.height)!
        let contentOffest = heroHeaderView.bounds.height
        let backgorundAlphaValue = max(0, min(1 - scrollOffest / contentOffest, 1.0))
        homeBackground.alpha = backgorundAlphaValue
    }
    
}

//MARK: - CellTapedAction extension
extension HomeVC :HomeTableViewCellDelegate {
    func homeTableViewCellDidTapped(_ cell: HomeTableViewCell, navigateTo vc: EntertainmentDetailsVC) {
        presentAsRoot(vc)
    }
    
}

//MARK: - HeroHeaderViewDelegate extension
extension HomeVC: HeroHeaderViewDelegate{
    func finishLoadingPoster() {
        loadingView.removeFromSuperview()
    }
    
}
