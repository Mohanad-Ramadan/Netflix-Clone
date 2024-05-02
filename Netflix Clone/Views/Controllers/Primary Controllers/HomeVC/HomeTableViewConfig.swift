//
//  HomeTableViewConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import Foundation


//MARK: - TableView Sections
extension HomeVC {
    enum Sections: Int {
        case  allTimeTV = 0, weekTrendingTV = 1 , popularMovies = 2, weekTrendingMovies = 3, upcomingMovies = 4
    }
    
    func embedSections(sectionNumbs: Int, cell: CollectionRowTableViewCell){
        switch sectionNumbs{
        case Sections.allTimeTV.rawValue:
            Task{
                do {
                    let media = try await NetworkManager.shared.getDataOf(.popularTVAllTime)
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.weekTrendingTV.rawValue:
            Task{
                do {
                    let media = try await NetworkManager.shared.getDataOf(.weekTrendingTV)
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.popularMovies.rawValue:
            Task{
                do {
                    let media = try await NetworkManager.shared.getDataOf(.popularMovies)
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.weekTrendingMovies.rawValue:
            Task{
                do {
                    let media = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.upcomingMovies.rawValue:
            Task{
                do {
                    let media = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        default: break
        }
    }
}
