//
//  PersistenceDataManager.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 9/1/2024.
//

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
    
    // array of items in the my list container to avoid data racing
    // when checking if an item is already in the list or not
    private var listIds = [Int64]()
    private var watchedIds = [Int64]()
    
    func initializeContainersArray() {
        Task {
            do {
                self.listIds = try await fetchMyListMedia().map{$0.id}
                self.watchedIds = try await fetchWatchedMedia().map{$0.id}
            }
            catch { print("Error fetching listArray: \(error.localizedDescription)") }
        }
    }
    
    
    //MARK: - Save To Containers
    // Function to save items of type MediaItems in the download container
    func addToMyListMedia(_ media: Media) async throws {
        guard isItemNewToList(item: media) else {return}
        
        let context = myListContainer.viewContext
        let item = MediaItem(context: context)
        
        item.id = Int64(media.id)
        item.originalName = media.originalName
        item.title = media.title
        item.overview = media.overview
        item.posterPath = media.posterPath
        
        listIds.append(item.id)
        
        do { return try context.save() }
        catch { throw DataBaseError.faliedToSaveData }
    }
    
    // Check For Duplicates
    func isItemNewToList(item: Media) -> Bool {
        let itemInList = listIds.contains(where: {$0 == item.id})
        return !itemInList
    }
    
    
    
    // Function to save items of type MediaItems in the other contai
    func saveWatchedItem(_ media: Media) async throws {
        guard isItemWatchedBefore(item: media) else {return}
        
        let context = watchedContainer.viewContext
        let item = WatchedItem(context: context)
        
        item.id = Int64(media.id)
        item.originalName = media.originalName
        item.title = media.title
        item.overview = media.overview
        item.posterPath = media.posterPath
        
        watchedIds.append(item.id)
        
        do { return try context.save() }
        catch { throw DataBaseError.faliedToSaveData }
    }
    
    // Check For Duplicates
    func isItemWatchedBefore(item: Media) -> Bool {
        let itemInList = watchedIds.contains(where: {$0 == item.id})
        return !itemInList
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
    
    //MARK: - Remove Item
    func deleteMediaFromList(_ item: Media) async throws{
        let mediaItem = await getItemFromList(item: item)
        let context = myListContainer.viewContext
        context.delete(mediaItem)
        
        defer { listIds.removeAll(where: { $0 == item.id }) }
        
        do { try context.save() }
        catch { throw DataBaseError.faliedToDeleteData }
        
    }
    
    func getItemFromList(item: Media) async -> MediaItem {
        let listItems = try? await PersistenceDataManager.shared.fetchMyListMedia()
        let wantedItem = (listItems?.filter {$0.id == item.id}.first)!
        return wantedItem
    }
    
    // watched media deletion method
    func deleteMediaFromWatched(_ item: Media) async throws{
        let watchedItem = await getItemFromWatched(item: item)
        let context = watchedContainer.viewContext
        context.delete(watchedItem)
        
        defer { watchedIds.removeAll(where: { $0 == item.id }) }
        
        do { try context.save() } 
        catch { throw DataBaseError.faliedToDeleteData }
        
    }
    
    func getItemFromWatched(item: Media) async -> WatchedItem {
        let listItems = try? await PersistenceDataManager.shared.fetchWatchedMedia()
        let wantedItem = (listItems?.filter {$0.id == item.id}.first)!
        return wantedItem
    }
    
}

