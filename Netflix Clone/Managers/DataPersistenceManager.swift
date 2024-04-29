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
    lazy var downloadContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NetflixCloneModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // Second persistent container for other media items
//    lazy var otherContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "OtherMedia")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Failed to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
    
    // Function to save items of type MediaItems in the download container
    func downloadMediaWith(model: Media, completion: @escaping (Result<Void,Error>) -> Void) {
        let context = downloadContainer.viewContext
        let item = MediaItems(context: context)
        
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
//    func saveMediaItem(model: MediaItems, completion: @escaping (Result<Void,Error>) -> Void) {
//        let context = otherContainer.viewContext
//        let item = MediaItems(context: context)
//        
//        item.id = model.id
//        item.originalName = model.originalName
//        item.title = model.title
//        item.overview = model.overview
//        item.posterPath = model.posterPath
//        
//        do {
//            try context.save()
//            completion(.success(()))
//        } catch {
//            completion(.failure(DataBaseError.faliedToSaveData))
//        }
//    }
    
    
    func fetchDownloadedMedias(completion: @escaping (Result<[MediaItems],Error>) -> Void ){
        let context = downloadContainer.viewContext
        let request: NSFetchRequest<MediaItems>
        request = MediaItems.fetchRequest()
        
        do {
            let media = try context.fetch(request)
            completion(.success(media))
        }catch {
            completion(.failure(DataBaseError.faliedTofetchData))
        }
        
    }
    
    func deleteMedias(model: MediaItems, completion: @escaping (Result<Void,Error>) -> Void ){
        let context = downloadContainer.viewContext
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.faliedToDeleteData))
        }
    }
    
    
    
}

