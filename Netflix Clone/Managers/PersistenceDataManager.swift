//
//  PersistenceDataManager.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 22/10/2023.
//

import Foundation
import CoreData
import UIKit


class PersistenceDataManager {

    static let shared = PersistenceDataManager()    
    
    
    //MARK: Declare Containers
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
    
    
    //MARK: - Save To Containers
    // Function to save items of type MediaItems in the download container
    func addToMyListMedia(_ media: Media) async throws {
        guard await isItemNewInList(item: media) else {return}
        
        let context = myListContainer.viewContext
        let item = MediaItem(context: context)
        
        item.id = Int64(media.id)
        item.originalName = media.originalName
        item.title = media.title
        item.overview = media.overview
        item.posterPath = media.posterPath
        
        do { return try context.save() }
        catch { throw DataBaseError.faliedToSaveData }
    }
    
    // Function to save items of type MediaItems in the other contai
    func saveWatchedItem(_ media: Media) async throws {
        let context = watchedContainer.viewContext
        let item = WatchedItem(context: context)
        
        item.id = Int64(media.id)
        item.originalName = media.originalName
        item.title = media.title
        item.overview = media.overview
        item.posterPath = media.posterPath
        
        do { return try context.save() }
        catch { throw DataBaseError.faliedToSaveData }
    }
    
    //MARK: - Fetch from Containers
    func fetchMyListMedia() async throws -> [MediaItem]{
        let context = myListContainer.viewContext
        let request: NSFetchRequest<MediaItem>
        request = MediaItem.fetchRequest()
        
        do { return try context.fetch(request) }
        catch { throw DataBaseError.faliedTofetchData }
    }
    
    
    func fetchWatchedMedia() async throws -> [WatchedItem] {
        let context = watchedContainer.viewContext
        let request: NSFetchRequest<WatchedItem>
        request = WatchedItem.fetchRequest()
        
        do { return try context.fetch(request) }
        catch { throw DataBaseError.faliedTofetchData }
        
    }
    
    //MARK: - Remove Item from MyList
    func deleteMediaFromMyList(_ item: MediaItem, completion: @escaping (Result<Void,Error>) -> Void ){
        let context = myListContainer.viewContext
        context.delete(item)
        
        do{
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.faliedToDeleteData))
        }
    }
    
    
    //MARK: - Check For Duplicates
    func isItemNewInList(item: Media) async -> Bool {
        let listItems = try? await PersistenceDataManager.shared.fetchMyListMedia()
        let checkItemInList = listItems?.contains(where: {$0.id == item.id}) ?? false
        return !checkItemInList
    }
    
}

