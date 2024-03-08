//
//  TableSections.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import Foundation


//MARK: - TableView Sections

enum Sections: Int {
    case  PopularTV = 0, WeekTrendingTV = 1 , PopularMovies = 2, WeekTrendingMovies = 3, UpcomingMovies = 4
}

func embedSections(sectionNumbs: Int, cell: HomeTableViewCell){
    switch sectionNumbs{
    case Sections.PopularTV.rawValue:
        Task{
            do {
                let entertainments = try await NetworkManager.shared.getDataOf(.popularTV)
                await cell.configureCollection(with: entertainments)
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
                let entertainments = try await NetworkManager.shared.getDataOf(.weekTrendingTV)
                await cell.configureCollection(with: entertainments)
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
                let entertainments = try await NetworkManager.shared.getDataOf(.popularMovies)
                await cell.configureCollection(with: entertainments)
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
                let entertainments = try await NetworkManager.shared.getDataOf(.weekTrendingMovies)
                await cell.configureCollection(with: entertainments)
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
                let entertainments = try await NetworkManager.shared.getDataOf(.discoverUpcoming)
                await cell.configureCollection(with: entertainments)
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
