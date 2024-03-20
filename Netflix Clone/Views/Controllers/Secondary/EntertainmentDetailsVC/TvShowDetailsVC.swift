//
//  TvShowDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class TvShowDetailsVC: EntertainmentDetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(for tvShow: Entertainment, isTrend: Bool = false, rank: Int = 0) {
        super.init()
        self.tvShow = tvShow
        fetchData(isTrend: isTrend, rank: rank)
        
    }
    
    private func fetchData(isTrend: Bool, rank: Int){
        Task {
            do {
                // get details
                let details: TVDetail = try await NetworkManager.shared.getDetailsFor(mediaId: tvShow.id, ofType: "tv")
                let viewModel = MovieViewModel(title: details.name, overview: details.overview, mediaType: "tv" ,releaseDate: details.lastAirDate)
                configureDetails(with: viewModel, isTrend: isTrend, rank: rank)
                
                // get cast
                let fetchedCast = try await NetworkManager.shared.getCastFor(mediaId: tvShow.id, ofType: "tv")
                let cast = fetchedCast.returnThreeCastSeperated(with: ", ")
                let director = fetchedCast.returnDirector()
                configureCast(with: MovieViewModel(cast: cast, director: director))
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Declare TvShows Subviews
    
    
    var tvShow: Entertainment!
    var episodes: Season!
    
    required init?(coder: NSCoder) {fatalError()}
}
