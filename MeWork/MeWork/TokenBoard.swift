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
    
    class func tokenBoard(withName name: String, backgroundColor colorString: String, andTokenNumber tokenNumber: Int) -> TokenBoard {
        
        let tokenBoard = NSEntityDescription.insertNewObject(forEntityName: TokenBoard.entityName, into: CoreDataManager.sharedInstance.managedObjectContext) as! TokenBoard
        
        tokenBoard.childName = name
        tokenBoard.backgroundColor = colorString
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
    @NSManaged public var tokenNumber: String?
    @NSManaged public var token: Token?
    @NSManaged public var reward: Reward?
    
}

// MARK: - Accessors for TokenBoards

extension TokenBoard {
    
    @objc(addTokenBoardRewardObject:)
    @NSManaged public func addToTokenBoardReward(_ value: Reward)
    
    @objc(removeTokenBoardRewardChoiceObject:)
    @NSManaged public func removeFromTokenBoardReward(_ value: Reward)
    
    @objc(addTokenBoardTokenObject:)
    @NSManaged public func addToTokenBoardToken(_ value: Token)
    
    @objc(removeTokenBoardTokenTokenObject:)
    @NSManaged public func removeFromTokenBoardToken(_ value: Token)
    
}
