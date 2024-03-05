//
//  ErrorMessages.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 05/03/2024.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
//    case unableToGetFavoriote = "Something went wrong when retrieving your favorties."
//    case unableToFavorite = "There was an error favoriting this user. Please try again."
//    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
