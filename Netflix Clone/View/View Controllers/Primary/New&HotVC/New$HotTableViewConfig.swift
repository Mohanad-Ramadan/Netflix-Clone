//
//  New&HotTableViewConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/01/2024.
//

import UIKit

extension NewAndHotVC {
    
    enum ButtonTapped: Int {
        case comingSoon = 0  , everyoneWatching = 1 , toptenTv = 2 , toptenMovies = 3
    }
    
    //MARK: - Fetching tableView data
    
    func handleUIAndDataFetching(){
        // UI first load with coming soon button selected
        categoryButtonsBar.comingSoonButtonTapped()
        
        // fetch the Data With a notification key to reload
        fetchData()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.categoryNewHotVCKey), object: nil, queue: nil) { _ in
            self.fetchData()
            
            // Scroll to top again
            self.newAndHotTable.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func fetchData(){
        let selectedButton = categoryButtonsBar.selectedButtonIndex
        
        switch selectedButton {
        case ButtonTapped.comingSoon.rawValue:
            APICaller.shared.getUpcomingMovies { results in
                switch results {
                case .success(let entertainments):
                    self.entertainments = entertainments
                    DispatchQueue.main.async {
                        self.newAndHotTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case ButtonTapped.everyoneWatching.rawValue:
            APICaller.shared.getTrending { results in
                switch results {
                case .success(let entertainments):
                    self.entertainments = entertainments
                    DispatchQueue.main.async {
                        self.newAndHotTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case ButtonTapped.toptenTv.rawValue:
            APICaller.shared.getTrendingTV { results in
                switch results {
                case .success(let entertainments):
                    self.entertainments = entertainments
                    DispatchQueue.main.async {
                        self.newAndHotTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            APICaller.shared.getTrendingMovies { results in
                switch results {
                case .success(let entertainments):
                    self.entertainments = entertainments
                    DispatchQueue.main.async {
                        self.newAndHotTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
