//
//  DetailsViewModel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 30/05/2024.
//

import Foundation

class DetailsViewModel {
    init(_ details: Detail) {
        if details.title != nil { movieDetails = details as? MovieDetail }
        else { tvDetails = details as? TVDetail }
    }
    
    private var tvDetails: TVDetail?
    private var movieDetails: MovieDetail?
    
    
    
}
