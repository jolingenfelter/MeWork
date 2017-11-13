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
    
    class func token(withName name: String) -> Token {
        
        let token = NSEntityDescription.insertNewObject(forEntityName: Token.entityName, into: CoreDataManager.sharedInstance.managedObjectContext) as! Token
        
        token.fileName = name
        token.date = Date()
        
        return token
    }
    
}

extension Token {
    
    @NSManaged public var fileName: String?
    @NSManaged public var date: Date?
    
}
