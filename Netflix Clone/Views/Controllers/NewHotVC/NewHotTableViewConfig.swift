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
            Task{
                do {
                    let entertainments = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                    self.entertainments = entertainments
                    newAndHotTable.reloadData()
                } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
//                    presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = false
            
        case ButtonTapped.everyoneWatching.rawValue:
            Task{
                do {
                    let entertainments = try await NetworkManager.shared.getDataOf(.allTrending)
                    self.entertainments = entertainments
                    newAndHotTable.reloadData()
                } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
//                    presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = true
            
        case ButtonTapped.toptenTv.rawValue:
            Task{
                do {
                    let entertainments = try await NetworkManager.shared.getDataOf(.allTrending)
                    self.entertainments = entertainments
                    newAndHotTable.reloadData()
                } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
//                    presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = true
            
        default:
            Task{
                do {
                    let entertainments = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                    self.entertainments = entertainments
                    newAndHotTable.reloadData()
                } catch let error as APIError {
//                    presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
//                    presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            // notify if it is trending category or not
            isTheTappedEntertainmentTrend = true
            
        }
        
    }
    
    
}
