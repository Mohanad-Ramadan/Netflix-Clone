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
    
    
    func downloadMediaWith(model: Media, completion: @escaping (Result<Void,Error>) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let item = MediaItems(context: context)
        
        item.id = Int64(model.id)
        item.originalName = model.originalName
        item.title = model.title
        item.overview = model.overview
        item.posterPath = model.posterPath

        
        do {
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DataBaseError.faliedToSaveData))
        }
        
    }
    
    func fetchDownloadedMedias(completion: @escaping (Result<[MediaItems],Error>) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<MediaItems>
        
        request = MediaItems.fetchRequest()
        
        do {
            let entertainments = try context.fetch(request)
            completion(.success(entertainments))
        }catch {
            completion(.failure(DataBaseError.faliedTofetchData))
        }
        
    }
    
    func deleteMedias(model: MediaItems, completion: @escaping (Result<Void,Error>) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DataBaseError.faliedToDeleteData))
        }
        
    }
    
    
    
}

