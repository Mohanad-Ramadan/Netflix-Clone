//
//  TableSections.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/01/2024.
//

import Foundation


//MARK: - TableView Sections

enum Sections: Int {
    case  TopSeries = 0, TrendingTVNow = 1 , PopularMovies = 2, TrendingMoviesNow = 3, UpcomingMovies = 4
}

func embedSections(sectionNumbs: Int, cell: HomeTableViewCell){
    switch sectionNumbs{
    case Sections.TopSeries.rawValue:
        NetworkManager.shared.getTopSeries { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.TrendingTVNow.rawValue:
        NetworkManager.shared.getTrendingTV { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.PopularMovies.rawValue:
        NetworkManager.shared.getPopular { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.TrendingMoviesNow.rawValue:
        NetworkManager.shared.getTrendingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.UpcomingMovies.rawValue:
        NetworkManager.shared.getUpcomingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    default:
        NetworkManager.shared.getTrendingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
