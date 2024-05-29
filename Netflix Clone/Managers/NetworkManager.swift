//
//  NetworkManager.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 2/1/2024.
//

import UIKit


//MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    
    //MARK: - Main Fetch Methods
    func getMedia(from stringURL: String) async throws -> [Media] {
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do {
            let fetchedData = try self.decoder.decode(MediaResponse.self, from: data)
            return fetchedData.results
        } catch { throw APIError.invalidData }
    }
    
    
    func getData<T: Codable>(from stringURL: String) async throws -> T {
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do { return try self.decoder.decode(T.self, from: data) }
        catch { throw APIError.invalidData }
    }
    
    
    //MARK: - Spacific Methods
    func getImagesFor(mediaId id: Int, ofType mediaType: String) async throws -> MediaImage {
        let stringURL = Constants.createImageURLWith(mediaType: mediaType, id: id)
        return try await getData(from: stringURL)
    }
    
    func getCastFor(mediaId id: Int, ofType mediaType: String) async throws -> Cast {
        let stringURL = Constants.createCastURLWith(mediaType: mediaType, id: id)
        return try await getData(from: stringURL)
    }
    
    func getTrailersFor(mediaId id: Int, ofType mediaType: String) async throws -> Trailer {
        let stringURL = Constants.createTrailersURLWith(mediaType: mediaType, id: id)
        return try await getData(from: stringURL)
    }

    func getDetailsFor<T: Codable>(mediaId id: Int, ofType mediaType: String) async throws -> T {
        let stringURL = Constants.createDetailsURLWith(mediaType: mediaType, id: id)
        return try await getData(from: stringURL)
    }

    func getSeasonDetailsFor(seriesId: Int, seasonNumber: Int) async throws -> SeasonDetail {
        let stringURL = Constants.createSeasonURLWith(id: seriesId, seasonNumber: seasonNumber)
        return try await getData(from: stringURL)
    }
    
    
    // media fetch methods
    func getDataOf(_ endpoint: Endpoints) async throws -> [Media] {
        let stringURL = Constants.createUrlWith(endpoint)
        return try await getMedia(from: stringURL)
    }
    
    
    func getMoreOf(
        genresId: String,
        unwantedGenresId: String = "",
        ofMediaType mediaType: String = "movie",
        page: Int = 1
    ) async throws -> [Media] {
        let stringURL = Constants.createMoreLikeURLWith(mediaType: mediaType, genresId: genresId, without: unwantedGenresId, page: page)
        return try await getMedia(from: stringURL)
    }
    
    
    func getSearches(of query: String, page: Int = 1) async throws -> [Media] {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {throw APIError.invalidURL}
        let stringURL = Constants.createSearchURLFor(query, page: page)
        return try await getMedia(from: stringURL)
    }
    
}

