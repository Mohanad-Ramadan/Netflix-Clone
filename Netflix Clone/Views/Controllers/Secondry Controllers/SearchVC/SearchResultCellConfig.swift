//
//  SearchResultCellConfig.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 20/04/2024.
//

import Foundation

extension SearchResultVC {
    
    //MARK: - get spacific genre media
    func fetchMoreLike(_ sectionGenres: String, unwantedGenresId: String, pages: Int = 5) async throws -> [Media] {
        var allMedia = [Media]()
        for page in 1..<pages {
            let media = try await NetworkManager.shared.getMoreOf(genresId: sectionGenres, unwantedGenresId: unwantedGenresId, page: page)
            allMedia.append(contentsOf: media)
        }
        return allMedia
    }
    
    //MARK: - Get most relevant
    func getMostRelevant(from desiredMedia: [Media]) -> [Media] {
        let relevantMedia = desiredMedia.filter { $0.title?.first == searchQuery?.first }
        let otherMedia = desiredMedia.filter { $0.title?.first != searchQuery?.first}
        // return 25 only from sorted media
        let sortedRelevantMedia = Array(relevantMedia + otherMedia.prefix(25))
        return sortedRelevantMedia
    }

    
    // fetch media that relevant to searchQuery for spacific genres
    func fetchMoreOf(
        for sectionGenresId: String,
        exclude unwantedGenres: String = "",
        to cell: CollectionRowTableViewCell
    ) {
        Task{
            do {
                let desiredMedia = try await fetchMoreLike(sectionGenresId, unwantedGenresId: unwantedGenres)
                let mostRelevant = getMostRelevant(from: desiredMedia)
                cell.configureCollection(with: mostRelevant)
            } catch let error as APIError {
                presentNFAlert(messageText: error.rawValue)
            } catch {
                presentTemporaryAlert(alertType: .connectivity)
            }
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
                    finishLoading()
                } catch let error as APIError {
                    presentNFAlert(messageText: error.rawValue)
                } catch {
                    presentTemporaryAlert(alertType: .connectivity)
                }
            }
            
        case Sections.action.rawValue:
            // ids of action and adventure in movies
            // "Action & Adventure" and "Sci-Fi & Fantasy" in tvs
            let sectionGenres = ["28", "12", "10759", "10765"].joined(separator: "|")
            let comedyGenre = "35"
            fetchMoreOf(for: sectionGenres, exclude: comedyGenre, to: cell)
            
        case Sections.crimeWar.rawValue:
            // ids of History, crime and war
            let sectionGenres = ["80", "36", "10752"].joined(separator: "|")
            let comedyGenre = "35"
            fetchMoreOf(for: sectionGenres, exclude: comedyGenre, to: cell)
            
        case Sections.animation.rawValue:
            // animation
            let animation = "16"
            fetchMoreOf(for: animation, to: cell)
            
        case Sections.comedy.rawValue:
            // ids of comedy and family
            let sectionGenres = ["35","10751"].joined(separator: ",")
            let animation = "16"
            fetchMoreOf(for: sectionGenres, exclude: animation, to: cell)
            
        default: break
        }
    }
    
    
    //MARK: - Sections enum
    enum Sections: Int {
        case  topResutls = 0, action = 1 , crimeWar = 2, animation = 3, comedy = 4
    }
    
}
