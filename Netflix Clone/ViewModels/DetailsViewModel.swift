//
//  DetailsViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 30/05/2024.
//

import Foundation


struct DetailsViewModel {
    private let details: Detail
    
    init(_ details: Detail) {self.details = details}
    
    private func checkIfMovie<T>(_ movieAction: (MovieDetail) -> T, ifSeries seriesAction: (TVDetail) -> T) -> T {
        if let movieDetail = details as? MovieDetail {
            return movieAction(movieDetail)
        } else {
            return seriesAction((details as? TVDetail)!)
        }
    }
    
    
    var id: Int? {details.id}
    var overview: String? {details.overview}
    var mediaType: String? { checkIfMovie { _ in "movie" } ifSeries: { _ in "tv" } }
    var genres: String? {details.genres.map{$0.name}.joined(separator: ", ") }
    var runtime: String? {(details as? MovieDetail)?.runtime?.formatTimeFromMinutes()}
    var mediaTypeLabel: String { checkIfMovie { _ in "F I L M" } ifSeries: { _ in "S E R I E S" } }
    var rankTypeLabel: String { checkIfMovie { _ in "Movies" } ifSeries: { _ in "Tv Shows" } }
    
    var title: String? {
        checkIfMovie {movieDetail in movieDetail.title} ifSeries: {seriesDetail in seriesDetail.name}
    }
    
    var dateLabel: String? {
        checkIfMovie {
            movieDetail in movieDetail.releaseDate?.extract().year
        } ifSeries: {
            seriesDetail in seriesDetail.firstAirDate?.extract().year
        }
    }
    
    var newLabel: String? {
        checkIfMovie {
            movieDetail in movieDetail.releaseDate?.isNewRelease() ?? false ? "New" : nil
        } ifSeries: {
            seriesDetail in seriesDetail.firstAirDate?.isNewRelease() ?? false ? "New" : nil
        }
    }
    
    var seasons: [Season]? {
        (details as? TVDetail)?.seasons
    }
    
    var genresIds: String? {
        let genreId = details.genres.map{String($0.id)}
        let stringIds = genreId.joined(separator: "|")
        return stringIds
    }
    
    var dateCountDownText: String? {
        let releaseDate = (details as? MovieDetail)?.releaseDate
        return releaseDate?.extract().dayMonth.getCountDownText()
    }
    
    var releaseDay: String? { (details as? MovieDetail)?.releaseDate?.extract().day }
    
    var releaseMonth: String? { (details as? MovieDetail)?.releaseDate?.extract().month }
    
    var viewedGenres: String? {details.genres.map{$0.name}.joined(separator: " • ") }
}

