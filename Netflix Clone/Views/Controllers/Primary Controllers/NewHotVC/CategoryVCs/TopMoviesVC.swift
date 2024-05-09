//
//  TopMoviesTVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/04/2024.
//

import UIKit

class TopMoviesVC: CategoryVC {
    
    //MARK: - configure view
    override func configureVC() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopMediaTableCell.self, forCellReuseIdentifier:  TopMediaTableCell.identifier)
    }
    
    override func configureTableHeader() {
        let headerTitle = NFPlainButton(title: "Top 10 Movies", fontSize: 20, fontWeight: .bold)
        headerTitle.configureButtonImageWith(.top10, placement: .leading, padding: 5)
        headerTitle.frame = CGRect(x: 0, y: 0, width: headerTitle.bounds.width, height: 50)
        tableView.tableHeaderView = headerTitle
    }
    
    //MARK: - fetch media
    override func fetchMedia() {
        guard media.isEmpty else {return}
        Task{
            do {
                let media = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
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
extension TopMoviesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return media.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopMediaTableCell.identifier, for: indexPath) as? TopMediaTableCell else {return UITableViewCell()}
        let media = media[indexPath.row]
        cell.configureMediaRank(at: indexPath.row)
        cell.configure(with: media)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 460 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let media = media[indexPath.row]
        presentAsRoot(MovieDetailsVC(for: media))
    }

}
