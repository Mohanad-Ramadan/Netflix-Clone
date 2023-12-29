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
    
    func getDiscoverdMovies(complition: @escaping (Result<[Entertainment], Error>) -> Void){
        guard let url = URL(string: Constants.discoverdMoviesURl) else {
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
    
    
    func getLogo(mediaType: String, id: Int, complition: @escaping (Result<Detail,Error>) -> Void){
        guard let url = URL(string: "\(Constants.entertainmentIdURL)/\(mediaType)/\(id)/images") else {
            return
        }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(EntertainmentLogo.self, from: data)
                    let highestVoteLogos = result.logos.sorted {$0.voteAverage > $1.voteAverage}
                    let englishHighVotedLogos = highestVoteLogos.filter {$0.iso6391 == "en"}
                    complition(.success(englishHighVotedLogos[0]))
                } catch {
//                    complition(.failure(APIError.failedToGetData))
                    print(String(describing: error))
                    print("Problem in logo api")
                }
                
            }
        task.resume()
    }
    
}



//MARK: - APIError
enum APIError: Error {
    case failedToGetData
}


//MARK: - generic getMethod

    

//func getResults<T: Codable>(for constantURL: String,complition: @escaping (Result<[T], Error>) -> Void){
//    if let url = URL(string: constantURL) {
//        let session = URLSession(configuration:.default)
//        let task = session.dataTask(with: url) { data, _ , error in
//            guard let data = data, error == nil else {
//                fatalError("Couldn't fetch the data from \(url) ")
//            }
//            do {
//                let result = try JSONDecoder().decode(T.self, from: data)
//                complition(.success(result as! [T]))
//            } catch {
//                complition(.failure(APIError.failedToGetData))
//            }
//
//        }
//        task.resume()
//    }
//}
