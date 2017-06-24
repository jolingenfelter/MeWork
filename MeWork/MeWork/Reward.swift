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
    
    func reward(withFileName name: String) -> Reward {
        
        let reward = NSEntityDescription.insertNewObject(forEntityName: Reward.entityName, into: CoreDataManager.sharedInstance.managedObjectContext) as! Reward
        
        reward.fileName = name
        reward.date = Date()
        
        return reward
        
    }
    
}

extension Reward {
    
    @NSManaged public var fileName: String?
    @NSManaged public var date: Date?
    
}
