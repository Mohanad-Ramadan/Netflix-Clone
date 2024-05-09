//
//  ComingSoonTVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/04/2024.
//

import UIKit

class ComingSoonVC: CategoryVC {
    
    //MARK: - Configure View
    override func configureVC() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComingSoonTableCell.self, forCellReuseIdentifier:  ComingSoonTableCell.identifier)
    }
    
    override func configureTableHeader() {
        let headerTitle = NFPlainButton(title: "Coming Soon", fontSize: 20, fontWeight: .bold)
        headerTitle.configureButtonImageWith(.popcorn, placement: .leading, padding: 5)
        headerTitle.frame = CGRect(x: 0, y: 0, width: headerTitle.bounds.width, height: 50)
        tableView.tableHeaderView = headerTitle
    }
    
    //MARK: - Fetch media
    override func fetchMedia() {
        guard media.isEmpty else {return}
        Task{
            do {
                let media = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                self.media = media
                tableView.reloadData()
                removeLoadingView()
            } catch let error as APIError {
                presentNFAlert(messageText: error.rawValue)
            } catch {
                presentDefaultError()
            }
        }
    }
    
}

// MARK: - Table view data source
extension ComingSoonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return media.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComingSoonTableCell.identifier, for: indexPath) as? ComingSoonTableCell else {return UITableViewCell()}
        let media = media[indexPath.row]
        cell.configure(with: media)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 460 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let media = media[indexPath.row]
        
        if media.mediaType == nil || media.mediaType == "movie" {
            let vc = MovieDetailsVC(for: media)
            presentAsRoot(vc)
        } else {
            let vc = TVDetailsVC(for: media)
            presentAsRoot(vc)
        }
    }
}


