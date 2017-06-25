//
//  TokenBoard.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import CoreData

class TokenBoard: NSManagedObject {
    
    static let entityName = "\(TokenBoard.self)"
    
    static var allTokenBoardsRequest: NSFetchRequest<NSFetchRequestResult> = {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: TokenBoard.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "childName", ascending: true)]
        
        return request
        
    }()
    
    class func tokenBoard(withName name: String, backgroundColor colorString: String, tokenImageName imageName: String, andTokenNumber tokenNumber: Int) -> TokenBoard {
        
        let tokenBoard = NSEntityDescription.insertNewObject(forEntityName: TokenBoard.entityName, into: CoreDataManager.sharedInstance.managedObjectContext) as! TokenBoard
        
        tokenBoard.childName = name
        tokenBoard.backgroundColor = colorString
        tokenBoard.tokenImageName = imageName
        tokenBoard.tokenNumber = String(tokenNumber)
        
        return tokenBoard
        
    }
    
    class func tokenBoard(withName name: String) -> TokenBoard {
        
        let tokenBoard = NSEntityDescription.insertNewObject(forEntityName: TokenBoard.entityName, into: CoreDataManager.sharedInstance.managedObjectContext) as! TokenBoard
        
        tokenBoard.childName = name
        
        return tokenBoard
        
    }
    
}

// MARK: - Attributes

extension TokenBoard {
    
    @NSManaged public var childName: String?
    @NSManaged public var backgroundColor: String?
    @NSManaged public var tokenImageName: String?
    @NSManaged public var tokenNumber: String?
    
}

// MARK: - Accessors for TokenBoards

extension TokenBoard {
    
    @objc(addChildRewardChoiceObject:)
    @NSManaged public func addToChildRewardChoice(_ value: Reward)
    
    @objc(removeChildRewardChoiceObject:)
    @NSManaged public func removeChildRewardChoice(_ value: Reward)
    
    @objc(addChildRewardChoices:)
    @NSManaged public func addToChildRewardChoices(_ value: NSSet)
    
    @objc(removeChildRewardChoices:)
    @NSManaged public func removeFromChildRewardChoices(_ value: NSSet)
    
}





















