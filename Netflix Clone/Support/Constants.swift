//
//  Constants.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 15/10/2023.
//

import Foundation


struct Constants {
    static let apiKey = "?api_key=db7efd1f212466edd2945ab1e9199ee1"
    static let trendingAllURL = "https://api.themoviedb.org/3/trending/all/week\(apiKey)"
    static let trendingMoviesURL = "https://api.themoviedb.org/3/trending/movie/week\(apiKey)"
    static let upcomingMoviesURL = "https://api.themoviedb.org/3/movie/upcoming\(apiKey)"
    static let topSeriesURL = "https://api.themoviedb.org/3/tv/top_rated\(apiKey)&language=en-US&page=1"
    static let trendingTvURL = "https://api.themoviedb.org/3/trending/tv/week\(apiKey)"
    static let popularURl = "https://api.themoviedb.org/3/movie/popular\(apiKey)"
    static let discoverdMoviesURl = "https://api.themoviedb.org/3/discover/movie\(apiKey)"
    static let searchURl = "https://api.themoviedb.org/3/search/multi\(apiKey)&include_adult=false&query="
    static let youtubeURL = "https://www.googleapis.com/youtube/v3/search?safeSearch=strict&key=AIzaSyA43IBo_SCZSMUn4HmhCF6q3DKdKxgBBbA&q="
    static let entertainmentIdURL = "https://api.themoviedb.org/3"
    
    
    static let posterAPI = "144|49vDLfPI5EU7PUqtVLCippbJb5KuyJ5mRUY7yiIX"
    
    static let notificationKey = "Fetch agian"
    static let categoryNewHotVCKey = "newButtonPressed"
    static let entertainmentVCKey = "newButtonPressed2"
}


//MARK: - Test url

//search URL
// https://api.themoviedb.org/3/search/movie?api_key=db7efd1f212466edd2945ab1e9199ee1&query=spider

//Top rated URl
// https://api.themoviedb.org/3/tv/top_rated?api_key=db7efd1f212466edd2945ab1e9199ee1&language=en-US&page=1

//trending URL
//tv url
// https://api.themoviedb.org/3/trending/tv/week?api_key=db7efd1f212466edd2945ab1e9199ee1

//movie url
// https://api.themoviedb.org/3/trending/movie/week?api_key=db7efd1f212466edd2945ab1e9199ee1

//upcoming URL
// https://api.themoviedb.org/3/movie/upcoming?api_key=db7efd1f212466edd2945ab1e9199ee1

//details URL
//movie https://api.themoviedb.org/3/movie/872585?api_key=db7efd1f212466edd2945ab1e9199ee1

//tv https://api.themoviedb.org/3/tv/108978?api_key=db7efd1f212466edd2945ab1e9199ee1

//images URl
// https://api.themoviedb.org/3/tv/57243/images?api_key=db7efd1f212466edd2945ab1e9199ee1

//[image Path url]
// https://image.tmdb.org/t/p/w500/vcFW09U4834DyFOeRZpsx9x1D3S.jpg

// https://image.tmdb.org/t/p/w500/t0MpJBr0oS5Yc1eXHiL05T5UDIT.png

//Videos
// https://api.themoviedb.org/3/movie/872585/videos?api_key=db7efd1f212466edd2945ab1e9199ee1

//Videos for tv
// https://api.themoviedb.org/3/tv/108978/videos?api_key=db7efd1f212466edd2945ab1e9199ee1

//Cast
// movie https://api.themoviedb.org/3/movie/872585/credits?api_key=db7efd1f212466edd2945ab1e9199ee1

//tv https://api.themoviedb.org/3/tv/108978/credits?api_key=db7efd1f212466edd2945ab1e9199ee1

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
