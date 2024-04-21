//
//  SearchResultTableViewConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/04/2024.
//

import Foundation


//MARK: - TableView Sections
extension SearchResultVC {
    enum Sections: Int {
        case  topResutls = 0, actionSiFi = 1 , awardTVShows = 2, animationMovies = 3, familyMovies = 4
    }
    
    func embedSections(sectionNumbs: Int, cell: CollectionRowTableViewCell){
        switch sectionNumbs{
        case Sections.topResutls.rawValue:
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
            
        case Sections.actionSiFi.rawValue:
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
            
        case Sections.awardTVShows.rawValue:
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
            
        case Sections.animationMovies.rawValue:
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
