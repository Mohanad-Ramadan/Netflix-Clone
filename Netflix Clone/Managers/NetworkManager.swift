//
//  NetworkManager.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 11/10/2023.
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
    
    func getDataOf(_ endpoint: Endpoints) async throws -> [Media] {
        let stringURL = Constants.createUrlWith(endpoint)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do {
            let fetchedData = try self.decoder.decode(MediaResponse.self, from: data)
            return fetchedData.results
        } catch {throw APIError.invalidData}
    }
    
    func getMoreLike(genresId: String, ofMediaType mediaType: String) async throws -> [Media] {
        let stringURL = Constants.createMoreLikeURLWith(mediaType: mediaType, genresId: genresId)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do {
            let fetchedData = try self.decoder.decode(MediaResponse.self, from: data)
            return fetchedData.results
        } catch {throw APIError.invalidData}
    }
    
    func getImagesFor(mediaId id: Int, ofType mediaType: String) async throws -> MediaImage {
        let stringURL = Constants.createImageURLWith(mediaType: mediaType, id: id)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do { return try self.decoder.decode(MediaImage.self, from: data) }
        catch { throw APIError.invalidData }
    }
    
    func getCastFor(mediaId id: Int, ofType mediaType: String) async throws -> Cast {
        let stringURL = Constants.createCastURLWith(mediaType: mediaType, id: id)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do { return try self.decoder.decode(Cast.self, from: data) }
        catch { throw APIError.invalidData }
    }
    
    func getTrailersFor(mediaId id: Int, ofType mediaType: String) async throws -> Trailer {
        let stringURL = Constants.createTrailersURLWith(mediaType: mediaType, id: id)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do { return try self.decoder.decode(Trailer.self, from: data) }
        catch { throw APIError.invalidData }
    }

    func getDetailsFor<T: Codable>(mediaId id: Int, ofType mediaType: String) async throws -> T {
        let stringURL = Constants.createDetailsURLWith(mediaType: mediaType, id: id)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do { return try self.decoder.decode(T.self, from: data) }
        catch { throw APIError.invalidData }
    }

    func getSeasonDetailsFor(seriesId: Int, seasonNumber: Int) async throws -> SeasonDetail {
        let stringURL = Constants.createSeasonURLWith(id: seriesId, seasonNumber: seasonNumber)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do { return try self.decoder.decode(SeasonDetail.self, from: data) }
        catch {throw APIError.invalidData }
    }
    
    func getSearches(of query: String) async throws -> [Media] {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {throw APIError.invalidURL}
        let stringURL = Constants.createSearchURLFor(query)
        guard let url = URL(string: stringURL) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do {
            let fetchedData = try self.decoder.decode(MediaResponse.self, from: data)
            return fetchedData.results
        } catch {throw APIError.invalidData}
    }
    
    func getTrailersIds(of query: String) async throws -> String {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {throw APIError.invalidURL}
        guard let url = URL(string: Constants.youtubeURL + query) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do {
            let fetchedData = try self.decoder.decode(YoutubeResponse.self, from: data)
            return fetchedData.items[0].id.videoId
        } catch {throw APIError.invalidData}
    }
    
}

