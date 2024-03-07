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
    
    func getDataOf(_ endpoint: Endpoints) async throws -> [Entertainment] {
        let endpoint = Constants.createUrlWith(endpoint)
        guard let url = URL(string: endpoint) else {throw APIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse}
        
        do {
            let fetchedData = try self.decoder.decode(EntertainmentResponse.self, from: data)
            return fetchedData.results
        } catch {throw APIError.invalidData}
    }
    
    
    func search(query: String,complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: Constants.searchURl + query) else {
            return
        }
        let session = URLSession(configuration:.default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(EntertainmentResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                complition(.failure(NFError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getImages(mediaType: String, id: Int, completion: @escaping (Result<Image, Error>) -> Void) {
        guard let imageURL = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)/images\(Constants.apiKey)") else {
            completion(.failure(NFError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: imageURL)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NFError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(Image.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NFError.failedToDecodeData))
            }
        }.resume()
    }
    
    func getCast(mediaType: String, id: Int, completion: @escaping (Result<Cast, Error>) -> Void) {
        guard let imageURL = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)/credits\(Constants.apiKey)") else {
            completion(.failure(NFError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: imageURL)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NFError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(Cast.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NFError.failedToDecodeData))
            }
        }.resume()
    }
    
    func getVedios(mediaType: String, id: Int, completion: @escaping (Result<Trailer, Error>) -> Void) {
        guard let imageURL = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)/videos\(Constants.apiKey)") else {
            completion(.failure(NFError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: imageURL)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NFError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(Trailer.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NFError.failedToDecodeData))
            }
        }.resume()
    }

    func getDetails<T: Decodable>(mediaType: String, id: Int, completion: @escaping (Result<T, Error>) -> Void) {
        guard let detailsURL = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)\(Constants.apiKey)") else {
            completion(.failure(NFError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: detailsURL)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NFError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(NFError.failedToDecodeData))
            }
        }.resume()
    }
    
    func getYoutubeVideos(query: String,complition: @escaping (Result<String, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: Constants.youtubeURL + query) else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                complition(.success(result.items[0].id.videoId))
            } catch {
                complition(.failure(NFError.failedToGetData))
                print(String(describing: error))
            }
            
        }
        task.resume()
    }
    
}



//MARK: - APIError
enum NFError: Error {
    case failedToGetData, failedToDecodeData, invalidURL
}

