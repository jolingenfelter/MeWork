//
//  TokenBoardViewModel.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/26/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TokenBoardModelView {
    @objc optional var rewardImageView: UIImageView { get }
    @objc optional var tokenBoardView: TokenBoardView { get }
    @objc optional var tokenCountLabel: UILabel { get }
}

public final class TokenBoardViewModel {
    
    var tokenBoard: TokenBoard?
    var backgroundColor: UIColor?
    var childName: String?
    var tokenNumber: Int?
    var rewardImage: UIImage?
    var tokenImage: UIImage?
    
    init(tokenBoard: TokenBoard?) {
        
        guard let tokenBoard = tokenBoard, let backgroundColor = tokenBoard.backgroundColor, let childName = tokenBoard.childName, let tokenNumberString = tokenBoard.tokenNumber, let tokenNumber = Int(tokenNumberString)   else {
            return
        }
        
        self.tokenBoard = tokenBoard
        self.backgroundColor = Color(rawValue: backgroundColor)!.color()
        self.childName = childName
        self.tokenNumber = tokenNumber
        
        let noImage = UIImage(named: "NoImage")!
        
        if let reward = tokenBoard.reward, let imageName = reward.fileName, let image = retrieveImage(imageName: imageName){
            rewardImage = image
        } else {
            rewardImage = noImage
        }
        
        if let token = tokenBoard.token, let imageName = token.fileName, let image = retrieveImage(imageName: imageName){
            tokenImage = image
        } else {
            tokenImage = noImage
        }
        
    }
    
}

extension TokenBoardViewModel {
    
    func configureView(_ view: TokenBoardModelView) {
        
    }
    
}










