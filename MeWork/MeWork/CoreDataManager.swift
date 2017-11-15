//
//  CoreDataManager.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    lazy var applicationsDocumentsDirectory: NSURL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
        
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = Bundle.main.url(forResource: "MeWork", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
        
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let url = self.applicationsDocumentsDirectory.appendingPathComponent("MeWor.sqlite")
        
        var failureReason = "There was an error loading the application's saved data."
        
        let migrationOptions = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        do {
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: migrationOptions)
            
        } catch {
            
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = failureReason as AnyObject?
            
            let wrappedError = NSError(domain: "com.jolingenfelter.mework.error", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
            
        }
        
        return coordinator
        
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
        
    }()
    
    // MARK: - CoreData saving support
    
    func saveContext() {
        
        if managedObjectContext.hasChanges {
        
            do {
                
                try managedObjectContext.save()
                
            } catch {
                
                let error = error as NSError
                
                NSLog("Unresolved error \(error), \(error.userInfo)")
                abort()
                
            }
        }
        
    }
    
}
