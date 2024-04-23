//
//  Constants.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 15/10/2023.
//

import Foundation


struct Constants {
    static let apiKey = "?api_key=db7efd1f212466edd2945ab1e9199ee1"
    static let baseURL = "https://api.themoviedb.org/3"
    
//    func createRequestWith(baseURL: String, queryItems: [URLQueryItem]) -> URLRequest{
//        let url = URL(string: baseURL)!
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        let queryItems: [URLQueryItem] = queryItems
//        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
//        var request = URLRequest(url: components.url!)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = [
//          "accept": "application/json",
//          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYjdlZmQxZjIxMjQ2NmVkZDI5NDVhYjFlOTE5OWVlMSIsInN1YiI6IjY1MmQ3NGNiMDI0ZWM4MDEzYzU4ZjVhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7f-onm6Fmd8SrdNF8iVZeD9-GcffA-3RLZNNOvvOFvQ"
//        ]
//        return request
//    }
    
    static func createUrlWith(_ endpoint: Endpoints) -> String{
        if endpoint == .discoverUpcoming || endpoint == .search {
            return "\(Constants.baseURL)\(endpoint.rawValue)&api_key=db7efd1f212466edd2945ab1e9199ee1"
        }
        return Constants.baseURL + endpoint.rawValue + Constants.apiKey
    }
    
    static func createMoreLikeURLWith(mediaType: String ,genresId: String, without genres: String, page: Int) -> String {
        let endpoint = "?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=\(genresId)&page=\(page)&without_genres=10767|10763|10764|\(genres)"
        if mediaType == "movie" {
            return "\(Constants.baseURL)/discover/movie\(endpoint)&api_key=db7efd1f212466edd2945ab1e9199ee1"
        } else {
            return "\(Constants.baseURL)/discover/tv\(endpoint)&api_key=db7efd1f212466edd2945ab1e9199ee1"
        }
    }
    
    static func createImageURLWith(mediaType: String ,id: Int) -> String {
        if mediaType == "movie" {return "\(Constants.baseURL)/movie/\(id)/images\(Constants.apiKey)"}
        else {return "\(Constants.baseURL)/tv/\(id)/images\(Constants.apiKey)"}
    }
    
    static func createSeasonURLWith(id: Int, seasonNumber: Int) -> String {
        "\(Constants.baseURL)/tv/\(id)/season/\(seasonNumber)\(Constants.apiKey)"
    }
    
    static func createCastURLWith(mediaType: String ,id: Int) -> String {
        if mediaType == "movie" {return "\(Constants.baseURL)/movie/\(id)/credits\(Constants.apiKey)"}
        else {return "\(Constants.baseURL)/tv/\(id)/credits\(Constants.apiKey)"}
    }
    
    static func createTrailersURLWith(mediaType: String ,id: Int) -> String {
        if mediaType == "movie" {return "\(Constants.baseURL)/movie/\(id)/videos\(Constants.apiKey)"}
        else {return "\(Constants.baseURL)/tv/\(id)/videos\(Constants.apiKey)"}
    }
    
    static func createDetailsURLWith(mediaType: String ,id: Int) -> String {
        if mediaType == "movie" {return "\(Constants.baseURL)/movie/\(id)\(Constants.apiKey)"}
        else {return "\(Constants.baseURL)/tv/\(id)\(Constants.apiKey)"}
    }
    
    static func createSearchURLFor(_ query: String, page: Int) -> String {
        let endpoint = Endpoints.search.rawValue
        return "\(Constants.baseURL)\(endpoint)&page=\(page)&api_key=db7efd1f212466edd2945ab1e9199ee1&query=\(query)"
    }

    static let youtubeURL = "https://www.googleapis.com/youtube/v3/search?safeSearch=strict&key=AIzaSyA43IBo_SCZSMUn4HmhCF6q3DKdKxgBBbA&q="
    static let mediaIdURL = "https://api.themoviedb.org/3"
    
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    
    static let notificationKey = "Fetch agian"
    static let categoryNewHotVCKey = "newButtonPressed"
    static let mediaVCKey = "newButtonPressed2"
}

enum Endpoints: String {
    case allTrending = "/trending/all/week"
    case weekTrendingMovies = "/trending/movie/week"
    case dayTrendingMovies = "/trending/movie/day"
    case weekTrendingTV = "/trending/tv/week"
    case dayTrendingTV = "/trending/tv/day"
    case popularMovies = "/movie/popular"
    case popularTV = "/tv/popular"
    case discoverUpcoming = "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&primary_release_year=2024&primary_release_date.gte=2024-03-15&primary_release_date.lte=2024-06-01&sort_by=popularity.desc"
    case search = "/search/multi?include_adult=false"
}


//MARK: - Test url

//search URL
// https://api.themoviedb.org/3/search/multi?api_key=db7efd1f212466edd2945ab1e9199ee1&query=spider&page=2

//Top rated URl
// https://api.themoviedb.org/3/tv/top_rated?api_key=db7efd1f212466edd2945ab1e9199ee1&language=en-US&page=1

//trending URL

//tv and movies
// https://api.themoviedb.org/3/trending/all/week?api_key=db7efd1f212466edd2945ab1e9199ee1

//tv url
// https://api.themoviedb.org/3/trending/tv/week?api_key=db7efd1f212466edd2945ab1e9199ee1

// tv popular
// https://api.themoviedb.org/3/tv/popular?api_key=db7efd1f212466edd2945ab1e9199ee1

//movie url
// https://api.themoviedb.org/3/trending/movie/week?api_key=db7efd1f212466edd2945ab1e9199ee1

// (upcoming)using discover api URL
// https://api.themoviedb.org/3/discover/tv?include_adult=false&include_video=false&language=en-US&page=1&primary_release_year=2024&primary_release_date.gte=2024-03-15&primary_release_date.lte=2024-06-01&sort_by=popularity.desc&api_key=db7efd1f212466edd2945ab1e9199ee1
// https://api.themoviedb.org/3/discover/tv?api_key=db7efd1f212466edd2945ab1e9199ee1&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&without_genres=10767

//details URL
//movie https://api.themoviedb.org/3/movie/872585?api_key=db7efd1f212466edd2945ab1e9199ee1

//tv https://api.themoviedb.org/3/tv/126308?api_key=db7efd1f212466edd2945ab1e9199ee1
//tv https://api.themoviedb.org/3/tv/108978?api_key=db7efd1f212466edd2945ab1e9199ee1

//season url
//"https://api.themoviedb.org/3/tv/126308/season/1?api_key=db7efd1f212466edd2945ab1e9199ee1"
//"https://api.themoviedb.org/3/tv/108545/season/1?api_key=db7efd1f212466edd2945ab1e9199ee1"

//images URl
// https://api.themoviedb.org/3/tv/57243/images?api_key=db7efd1f212466edd2945ab1e9199ee1

//[image Path url]
// https://image.tmdb.org/t/p/w500/vcFW09U4834DyFOeRZpsx9x1D3S.jpg

// https://image.tmdb.org/t/p/w500/t0MpJBr0oS5Yc1eXHiL05T5UDIT.png
// stillpath for episode (episode thumbnail)
// https://image.tmdb.org/t/p/w500/cK5bnO5LeBimz6oibtnLCnOmUSJ.jpg

//Videos
// https://api.themoviedb.org/3/movie/872585/videos?api_key=db7efd1f212466edd2945ab1e9199ee1

//Videos for tv
// https://api.themoviedb.org/3/tv/108978/videos?api_key=db7efd1f212466edd2945ab1e9199ee1

//Cast
// movie https://api.themoviedb.org/3/movie/872585/credits?api_key=db7efd1f212466edd2945ab1e9199ee1

//tv https://api.themoviedb.org/3/tv/108978/credits?api_key=db7efd1f212466edd2945ab1e9199ee1
//tv https://api.themoviedb.org/3/tv/126308/credits?api_key=db7efd1f212466edd2945ab1e9199ee1


// youtube api
// https://www.googleapis.com/youtube/v3/search?safeSearch=strict&key=AIzaSyA43IBo_SCZSMUn4HmhCF6q3DKdKxgBBbA&q=Wonka%20They%20Call%20Me%20Lofty

/*
The image resolutions to download
      "w92",
      "w154",
      "w185",
      "w342",
      "w500",
      "w780",
      "original"
*/
