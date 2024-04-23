//
//  SearchResultCellConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/04/2024.
//

import Foundation

extension SearchResultVC {
    //MARK: - get spacific genre media 
    func fetchMoreLike(_ sectionGenres: String, unwanted: String = "" , mediaType: String = "movie", pages: Int = 5) async throws -> [Media] {
        var allMedia = [Media]()
        for page in 1..<pages {
            let media = try await NetworkManager.shared.getMoreOf(genresId: sectionGenres, unwantedGenresId: unwanted, ofMediaType: mediaType, page: page)
            allMedia.append(contentsOf: media)
        }
        return allMedia
    }
    
    //MARK: - Get most relevant
    func getMostRelevant(from desiredMedia: [Media], mediaType: String = "movie") -> [Media] {
        if mediaType == "movie" {
            let relevantMedia = desiredMedia.filter { $0.title?.first == searchQuery?.first }
            let otherMedia = desiredMedia.filter { $0.title?.first != searchQuery?.first}
            // return 25 only from sorted media
            let sortedRelevantMedia = Array(relevantMedia + otherMedia.prefix(25))
            return sortedRelevantMedia
        } else {
            // tv media
            let relevantMedia = desiredMedia.filter { $0.originalName?.first == searchQuery?.first }
            let otherMedia = desiredMedia.filter { $0.originalName?.first != searchQuery?.first}
            // return 25 only from sorted media
            let sortedRelevantMedia = Array(relevantMedia + otherMedia.prefix(25))
            return sortedRelevantMedia
        }
    }

    //MARK: - Configure section cells
    func configureSearchResults(with query: String, section: Int, for cell: CollectionRowTableViewCell) {
        switch section {
        case Sections.topResutls.rawValue: 
            Task{
                do {
                    let searchResult = try await NetworkManager.shared.getSearches(of: query)
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
                    // fetch
                    let desiredMedia = try await fetchMoreLike(sectionGenresId, unwanted: comedyGenreId)
                    let mostRelevant = getMostRelevant(from: desiredMedia)
                    cell.configureCollection(with: mostRelevant)
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
                    // fetch
                    let desiredMedia = try await fetchMoreLike(sectionGenresId, unwanted: comedyGenreId)
                    let mostRelevant = getMostRelevant(from: desiredMedia)
                    cell.configureCollection(with: mostRelevant)
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
                    // fetch
                    let desiredMedia = try await fetchMoreLike(animationId)
                    let mostRelevant = getMostRelevant(from: desiredMedia)
                    cell.configureCollection(with: mostRelevant)
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
                    // fetch
                    let desiredMedia = try await fetchMoreLike(sectionGenresId, unwanted: animationGenreId)
                    let mostRelevant = getMostRelevant(from: desiredMedia)
                    cell.configureCollection(with: mostRelevant)
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
    
    
    //MARK: - Sections enum
    enum Sections: Int {
        case  topResutls = 0, action = 1 , crimeWar = 2, animation = 3, comedy = 4
    }
}
