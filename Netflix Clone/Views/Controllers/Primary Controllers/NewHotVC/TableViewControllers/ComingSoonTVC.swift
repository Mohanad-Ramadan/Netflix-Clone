//
//  ComingSoonTVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/04/2024.
//

import UIKit

class ComingSoonTVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableConfigure
        tableView.backgroundColor = .clear
        tableView.register(ComingSoonTableCell.self, forCellReuseIdentifier:  ComingSoonTableCell.identifierComing)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
//        tableView.estimatedRowHeight = 400
//        tableView.rowHeight = UITableView.automaticDimension
        // fetch data
        fetchMedia()
    }
    
    // fetch media function
    func fetchMedia() {
        guard media.isEmpty else {return}
        Task{
            do {
                let media = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComingSoonTableCell.identifierComing, for: indexPath) as? ComingSoonTableCell else {return UITableViewCell()}
        let media = media[indexPath.row]
        cell.configure(with: media)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 460 }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
