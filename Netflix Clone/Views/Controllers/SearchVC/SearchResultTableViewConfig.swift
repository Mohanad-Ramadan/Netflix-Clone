//
//  SearchResultTableViewConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/04/2024.
//

import Foundation

enum Sections: Int {
    case  topResutls = 0, action = 1 , crimeWar = 2, animation = 3, comedy = 4
}


//MARK: - TableView Sections
extension SearchResultVC {

    func configureSearchResults(with query: String, sections: Int, for cell: CollectionRowTableViewCell) {
        
        switch sections {
        case Sections.topResutls.rawValue: 
            Task{
                do {
                    let pageOneResults = try await NetworkManager.shared.getSearches(of: query, page: 1)
                    let pageTwoResults = try await NetworkManager.shared.getSearches(of: query, page: 2)
                    let searchResult = pageOneResults + pageTwoResults
                    cell.configureCollection(with: searchResult)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.action.rawValue:
            Task{
                do {
                    // ids of action and adventure in movies
                    // "Action & Adventure" and "Sci-Fi & Fantasy" in tvs
                    let sectionGenresId = ["28", "12", "10759", "10765"].joined(separator: "|")
                    let comedyGenreId = "35"
                    let media = try await NetworkManager.shared.getMoreOf(genresId: sectionGenresId, unwantedGenresId: comedyGenreId, ofMediaType: "movie")
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.crimeWar.rawValue:
            Task{
                do {
                    // ids of History, crime and war
                    let sectionGenresId = ["80", "36", "10752"].joined(separator: "|")
                    let comedyGenreId = "35"
                    let media = try await NetworkManager.shared.getMoreOf(genresId: sectionGenresId, unwantedGenresId: comedyGenreId, ofMediaType: "movie")
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.animation.rawValue:
            Task{
                do {
                    // animation
                    let animationId = ["16"].joined(separator: "|")
                    let media = try await NetworkManager.shared.getMoreOf(genresId: animationId, ofMediaType: "movie")
                    cell.configureCollection(with: media)
                } catch let error as APIError {
                    //                presentGFAlert(messageText: error.rawValue)
                    print(error)
                } catch {
                    //                presentDefaultError()
                    print(error.localizedDescription)
                }
            }
            
        case Sections.comedy.rawValue:
            Task{
                do {
                    // ids of comedy and family
                    let sectionGenresId = ["35","10751"].joined(separator: ",")
                    let animationGenreId = "16"
                    let media = try await NetworkManager.shared.getMoreOf(genresId: sectionGenresId, unwantedGenresId: animationGenreId, ofMediaType: "movie")
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
