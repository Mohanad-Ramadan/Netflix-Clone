//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 11/10/2023.
//

import Foundation


class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let url = URL(string: Constants.trendingMoviesURL) else {return}
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
                complition(.failure(APIError.failedToGetData))
                print("couldn't decode the results for trending movies ")
            }
            
        }
        task.resume()
    }
    
    
    func getTrendingTV(complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let url = URL(string: Constants.trendingTvURL) else {
            return
        }
        let session = URLSession(configuration:.default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(EntertainmentResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                complition(.failure(APIError.failedToGetData))
                print("couldn't decode the results for trending TV error: \(error)")
            }
            
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let url = URL(string: Constants.upcomingMoviesURL) else {
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
                complition(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getTopSeries(complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let url = URL(string: Constants.topSeriesURL) else {
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
                complition(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getPopular(complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let url = URL(string: Constants.popularURl) else {
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
                complition(.failure(APIError.failedToGetData))
                print("couldn't decode the results for popular")
            }
            
        }
        task.resume()
        
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
                complition(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getYoutubeTrailer(query: String,complition: @escaping (Result<VideoObject, Error>) -> Void){
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
                complition(.success(result.items[0]))
            } catch {
                complition(.failure(APIError.failedToGetData))
                print(String(describing: error))
            }
            
        }
        task.resume()
    }
    
    func getImages(mediaType: String, id: Int, completion: @escaping (Result<EntertainmentImage, Error>) -> Void) {
        guard let imageURL = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)/images\(Constants.apiKey)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: imageURL)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(EntertainmentImage.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedToDecodeData))
            }
        }.resume()
    }

    func getDetails(mediaType: String, id: Int, completion: @escaping (Result<Detail, Error>) -> Void) {
        guard let detailsURL = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)\(Constants.apiKey)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: detailsURL)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(Detail.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedToDecodeData))
            }
        }.resume()
    }
    
//    func getNewAndHotData(mediaType: String, id: Int, completion: @escaping (Result<(EntertainmentImage, Detail), Error>) -> Void) {
//        let group = DispatchGroup()
//        
//        var imagesResult: EntertainmentImage?
//        var detailsResult: Detail?
//        
//        // Fetch images
//        group.enter()
//        getImages(mediaType: mediaType, id: id) { result in
//            switch result {
//            case .success(let images):
//                imagesResult = images
//            case .failure(let error):
//                print("Error fetching images:", error)
//            }
//            group.leave()
//        }
//        
//        // Fetch details
//        group.enter()
//        getDetails(mediaType: mediaType, id: id) { result in
//            switch result {
//            case .success(let details):
//                detailsResult = details
//            case .failure(let error):
//                print("Error fetching details:", error)
//            }
//            group.leave()
//        }
//        
//        group.notify(queue: .main) {
//            guard let imagesResult = imagesResult, let detailsResult = detailsResult else {
//                completion(.failure(APIError.failedToGetData))
//                return
//            }
//            
//            let combinedResult: (EntertainmentImage, Detail) = (imagesResult, detailsResult)
//            completion(.success(combinedResult))
//        }
//    }
    
}



//MARK: - APIError
enum APIError: Error {
    case failedToGetData, failedToDecodeData, invalidURL
}

