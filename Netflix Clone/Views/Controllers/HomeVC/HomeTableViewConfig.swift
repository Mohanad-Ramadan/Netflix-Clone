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
        case  PopularTV = 0, WeekTrendingTV = 1 , PopularMovies = 2, WeekTrendingMovies = 3, UpcomingMovies = 4
    }
    
    func embedSections(sectionNumbs: Int, cell: CollectionRowTableViewCell){
        switch sectionNumbs{
        case Sections.PopularTV.rawValue:
            Task{
                do {
                    let media = try await NetworkManager.shared.getDataOf(.popularTV)
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.WeekTrendingTV.rawValue:
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
            
        case Sections.PopularMovies.rawValue:
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
            
        case Sections.WeekTrendingMovies.rawValue:
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
            
        default:
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
        }
    }
}
