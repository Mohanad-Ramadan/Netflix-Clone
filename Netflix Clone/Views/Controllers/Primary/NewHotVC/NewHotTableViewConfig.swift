//
//  New&HotTableViewConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/01/2024.
//

import UIKit

extension NewHotVC {
    
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
            NetworkManager.shared.getUpcomingMovies { results in
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
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = false
            
        case ButtonTapped.everyoneWatching.rawValue:
            NetworkManager.shared.getTrending { results in
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
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = true
            
        case ButtonTapped.toptenTv.rawValue:
            NetworkManager.shared.getTrendingTV { results in
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
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = true
            
        default:
            NetworkManager.shared.getTrendingMovies { results in
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
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = true
            
        }
        
    }
    
    
}
