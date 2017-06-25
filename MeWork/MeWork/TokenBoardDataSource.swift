//
//  TokenBoardDataSource.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

class TokenBoardDataSource: NSObject {
    
    let tableView: UITableView
    let fetchedResultsController: TokenBoardFetchedResultsController
    
    init(fetchedResultsController: TokenBoardFetchedResultsController, tableView: UITableView) {
        
        self.tableView = tableView
        self.fetchedResultsController = fetchedResultsController
        
        super.init()
        
    }
    
    func performFetch(withPredicate predicate: NSPredicate) {
        self.fetchedResultsController.performFetch(withPredicate: predicate)
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension TokenBoardDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tokenBoard = fetchedResultsController.object(at: indexPath) as! TokenBoard
        
        cell.textLabel?.text = tokenBoard.childName
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let tokenBoard = fetchedResultsController.object(at: indexPath) as! TokenBoard
        
        if editingStyle == .delete {
            CoreDataManager.sharedInstance.managedObjectContext.delete(tokenBoard)
            CoreDataManager.sharedInstance.saveContext()
        }
        
    }
}
