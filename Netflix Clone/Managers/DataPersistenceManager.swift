//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 22/10/2023.
//

import Foundation
import CoreData
import UIKit


class DataPersistenceManager {
    
    enum DataBaseError: Error{
        case faliedToSaveData
        case faliedTofetchData
        case faliedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    
    // First persistent container for downloading media items
    lazy var myListContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyListNetflixModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // Second persistent container for other media items
    lazy var watchedContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WatchedNetflixModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // Function to save items of type MediaItems in the download container
    func downloadMediaWith(model: Media, completion: @escaping (Result<Void,Error>) -> Void) {
        let context = myListContainer.viewContext
        let item = MediaItem(context: context)
        
        item.id = Int64(model.id)
        item.originalName = model.originalName
        item.title = model.title
        item.overview = model.overview
        item.posterPath = model.posterPath
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.faliedToSaveData))
        }
    }
    
    // Function to save items of type MediaItems in the other container
    func saveWatchedItem(model: Media, completion: @escaping (Result<Void,Error>) -> Void) {
        let context = watchedContainer.viewContext
        let item = WatchedItem(context: context)
        
        item.id = Int64(model.id)
        item.originalName = model.originalName
        item.title = model.title
        item.overview = model.overview
        item.posterPath = model.posterPath
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.faliedToSaveData))
        }
    }
    
    
    func fetchDownloadedMedias(completion: @escaping (Result<[MediaItem],Error>) -> Void ){
        let context = myListContainer.viewContext
        let request: NSFetchRequest<MediaItem>
        request = MediaItem.fetchRequest()
        
        do {
            let media = try context.fetch(request)
            completion(.success(media))
        }catch {
            completion(.failure(DataBaseError.faliedTofetchData))
        }
        
    }
    
    func fetchWatchedMedias(completion: @escaping (Result<[WatchedItem],Error>) -> Void ){
        let context = watchedContainer.viewContext
        let request: NSFetchRequest<WatchedItem>
        request = WatchedItem.fetchRequest()
        
        do {
            let media = try context.fetch(request)
            completion(.success(media))
        }catch {
            completion(.failure(DataBaseError.faliedTofetchData))
        }
        
    }
    
    func deleteMedias(model: MediaItem, completion: @escaping (Result<Void,Error>) -> Void ){
        let context = myListContainer.viewContext
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.faliedToDeleteData))
        }
    }
    
    
    
}

