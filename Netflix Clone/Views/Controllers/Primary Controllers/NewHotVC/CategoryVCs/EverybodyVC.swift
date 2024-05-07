//
//  EverybodyTVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 01/04/2024.
//

import UIKit

class EverybodyVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        loadingView.frame = view.bounds
    }
    
    //MARK: - configure view
    func configureVC() {
        [tableView,loadingView].forEach {view.addSubview($0)}
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureTableHeader() {
        let headerTitle = NFPlainButton(title: "Everyone's Watching", fontSize: 20, fontWeight: .bold)
        headerTitle.configureButtonImageWith(.fire, placement: .leading, padding: 5)
        headerTitle.frame = CGRect(x: 0, y: 0, width: headerTitle.bounds.width, height: 50)
        tableView.tableHeaderView = headerTitle
    }
    
    //MARK: - remove LoadingView
    func removeLoadingView() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            UIView.animate {self.loadingView.alpha = 0}
        }
    }
    
    //MARK: - fetch media
    func fetchMedia() {
        guard media.isEmpty else {return}
        Task{
            do {
                let media = try await NetworkManager.shared.getDataOf(.allTrending)
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
    
    //MARK: - Declare Variables
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.register(EveryonesTableCell.self, forCellReuseIdentifier:  EveryonesTableCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let loadingView = NewHotLoadingUIView()
    
    private var media: [Media] = [Media]()
    
}    

// MARK: - Table view data source
    
extension EverybodyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return media.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EveryonesTableCell.identifier, for: indexPath) as? EveryonesTableCell else {return UITableViewCell()}
        let media = media[indexPath.row]
        cell.configure(with: media)
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


