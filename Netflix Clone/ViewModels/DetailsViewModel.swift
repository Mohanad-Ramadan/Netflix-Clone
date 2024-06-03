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
    
    private func isMovie<T>(_ movieAction: (MovieDetail) -> T, isTvShow tvShowAction: (TVDetail) -> T) -> T {
        if let movieDetail = details as? MovieDetail { return movieAction(movieDetail) }
        else if let tvShowDetail = details as? TVDetail { return tvShowAction(tvShowDetail) }
        else { preconditionFailure("Details must be either a MovieDetail or a TVDetail") }
    }
    
    
    var id: Int? {details.id}
    var overview: String? {details.overview}
    var mediaType: String? { isMovie { _ in "movie" } isTvShow: { _ in "tv" } }
    var genres: String? {details.genres.map{$0.name}.joined(separator: ", ") }
    var runtime: String? {(details as? MovieDetail)?.runtime?.formatTimeFromMinutes()}
    var mediaTypeLabel: String { isMovie { _ in "F I L M" } isTvShow: { _ in "S E R I E S" } }
    var rankTypeLabel: String { isMovie { _ in "Movies" } isTvShow: { _ in "Tv Shows" } }
    
    var title: String? {
        isMovie {movieDetail in movieDetail.title} isTvShow: {seriesDetail in seriesDetail.name}
    }
    
    var dateLabel: String? {
        isMovie {
            movieDetail in movieDetail.releaseDate?.extract().year
        } isTvShow: {
            seriesDetail in seriesDetail.firstAirDate?.extract().year
        }
    }
    
    var newLabel: String? {
        isMovie {
            movieDetail in movieDetail.releaseDate?.isNewRelease() ?? false ? "New" : nil
        } isTvShow: {
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

