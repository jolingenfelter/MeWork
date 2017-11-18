//
//  Reward.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import CoreData

class Reward: NSManagedObject {
    
    static let entityName = "\(Reward.self)"
    
    static var allRewardsFetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Reward.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        return request
        
    }()
    
    class func reward(withName name: String, inContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) -> Reward {
        
        let reward = NSEntityDescription.insertNewObject(forEntityName: Reward.entityName, into: inContext) as! Reward
        
        reward.fileName = name
        reward.date = Date()
        
        return reward
        
    }
    
}

extension Reward {
    
    @NSManaged public var fileName: String?
    @NSManaged public var date: Date?
    
}
