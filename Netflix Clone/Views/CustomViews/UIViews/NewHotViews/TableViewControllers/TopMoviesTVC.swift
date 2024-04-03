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
        
        //tableView configure
        tableView.backgroundColor = .clear
        tableView.register(NewHotTableViewCell.self, forCellReuseIdentifier:  NewHotTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        fetchComingSoonMedia()
    }
    
    // fetch media function
    private func fetchComingSoonMedia() {
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
    
    private var media: [Media] = [Media]()

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
