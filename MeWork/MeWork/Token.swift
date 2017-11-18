//
//  Token.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/13/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import CoreData

class Token: NSManagedObject {
    
    static let entityName = "\(Token.self)"
    
    static let allTokensFetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Token.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        return request
    }()
    
    class func token(withName name: String, inContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) -> Token {
        
        var token: Token?
        
        checkForDuplicate(tokenWithName: name) { (duplicateToken) in
            if let duplicateToken = duplicateToken {
                token = duplicateToken
            } else {
                
                let newToken = NSEntityDescription.insertNewObject(forEntityName: Token.entityName, into: inContext) as! Token
                
                newToken.fileName = name
                newToken.date = Date()
                
                token = newToken
                
            }
       }
        
        return token!
    }
    
    private class func checkForDuplicate(tokenWithName: String, inContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext, completion: (Token?) -> ()) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Token.entityName)
        let predicate = NSPredicate(format: "fileName == %@", tokenWithName)
        fetchRequest.predicate = predicate
        
        var duplicateToken: Token?
        
        do {
            
            let results = try inContext.fetch(fetchRequest) as! [Token]
            duplicateToken = results.first
            completion(duplicateToken)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}

extension Token {
    
    @NSManaged public var fileName: String?
    @NSManaged public var date: Date?
    
}
