//
//  TopMoviesTVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/04/2024.
//

import UIKit

class TopMoviesTVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        tableView.register(NewHotTableViewCell.self, forCellReuseIdentifier:  NewHotTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        configureTableHeader()
        fetchMedia()
    }
    
    func configureTableHeader() {
        let headerTitle = NFPlainButton(title: "Top 10 Movies", fontSize: 20, fontWeight: .bold)
        headerTitle.configureButtonImageWith(.top10, width: 25, height: 25, placement: .leading, padding: 5)
        headerTitle.frame = CGRect(x: 0, y: 0, width: headerTitle.bounds.width, height: 50)
        tableView.tableHeaderView = headerTitle
    }
    
    // fetch media function
    func fetchMedia() {
        guard media.isEmpty else {return}
        Task{
            do {
                let media = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                self.media = media
                tableView.reloadData()
            } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                print(error)
            } catch {
//                    presentDefaultError()
                print(error.localizedDescription)
            }
        }
    }
    
    var media: [Media] = [Media]()

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return media.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewHotTableViewCell.identifier, for: indexPath) as? NewHotTableViewCell else {return UITableViewCell()}
        let media = media[indexPath.row]
        cell.configure(with: media)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 430 }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let media = media[indexPath.row]
        presentAsRoot(MovieDetailsVC(for: media))
    }

}
