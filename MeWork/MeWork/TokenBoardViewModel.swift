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
    @objc optional var titleLabel: UILabel { get }
    @objc optional var imageView: UIImageView { get }
    @objc optional var tokenCountLabel: UILabel { get }
}

public final class TokenBoardViewModel {
    
    var tokenBoard: TokenBoard?
    var backgroundColor: UIColor?
    var childName: String?
    var tokenNumber: Int?
    var tokensEarned = 0
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
        rewardImageViewSetup(view: view)
        tokenCountLabelSetup(view: view)
        titleLabelSetup(view: view)
    }
    
}

private extension TokenBoardViewModel {
    
    func rewardImageViewSetup(view: TokenBoardModelView) {
        view.imageView?.contentMode = .scaleAspectFill
        view.imageView?.clipsToBounds = true
        view.imageView?.layer.masksToBounds = true
        view.imageView?.layer.borderColor = UIColor.white.cgColor
        view.imageView?.layer.cornerRadius = 10
        view.imageView?.layer.borderWidth = 1.5
    }
    
    func tokenCountLabelSetup(view: TokenBoardModelView) {
        if let tokenNumber = tokenNumber {
            view.tokenCountLabel?.text = "0\(tokenNumber)"
        }
        view.tokenCountLabel?.textColor = .lightGray
        view.tokenCountLabel?.textAlignment = .center
    }
    
    func titleLabelSetup(view: TokenBoardModelView) {
        view.titleLabel?.text = "I am working for..."
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.textColor = .white
    }
}








