//
//  TokenBoardFetchedResultsController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

class TokenBoardFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>, NSFetchedResultsControllerDelegate {
    
    private let tableView: UITableView
    
    init(fetchRequest: NSFetchRequest<NSFetchRequestResult>, managedObjectContext: NSManagedObjectContext, tableView: UITableView) {
        
        self.tableView = tableView
        
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        
        executeFetch()
        
    }
    
    func executeFetch() {
        
        do {
            
            try performFetch()
            
        } catch let error as NSError {
            
            print("Unresolved error: \(error.localizedDescription)")
            
        }
        
    }
    
    func performFetch(withPredicate predicate: NSPredicate) {
        
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: nil)
        fetchRequest.predicate = predicate
        executeFetch()
        
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.reloadData()
            
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CheckForZeroTokenBoards"), object: nil)
        
    }

}

