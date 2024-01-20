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
        APICaller.shared.getTopSeries { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.TrendingTVNow.rawValue:
        APICaller.shared.getTrendingTV { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.PopularMovies.rawValue:
        APICaller.shared.getPopular { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.TrendingMoviesNow.rawValue:
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.UpcomingMovies.rawValue:
        APICaller.shared.getUpcomingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    default:
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
