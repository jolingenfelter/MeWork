//
//  TokenLibraryFlowLayout.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/14/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class TokenLibraryFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
         super.init()
        
        switch UIDevice.current.userInterfaceIdiom {
            
            // itemSize for iPads
            
            case .pad:
            
            // iPad Pro 12.9 inch
            if ScreenSize.SCREEN_MAX_LENGTH == 1366.0 {
            
                itemSize = CGSize(width: 300, height: 300)
                
            // iPad Pro 10.5 inch
            } else if ScreenSize.SCREEN_MAX_LENGTH == 1112.0 {
            
                itemSize = CGSize(width: 250, height: 250)
            
            // iPad 9.7 inch and mini
            } else {
            
                itemSize = CGSize(width: 200, height: 200)
                
            }
            
            // itemSize for iPhones
            
            case .phone:
            
            // iPhone 5 Size
            if ScreenSize.SCREEN_MAX_LENGTH == 568.0 {
            
                itemSize = CGSize(width: 150, height: 150)
            
            // iPhone 6 Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 667.0 {
            
                itemSize = CGSize(width: 170, height: 170)
            
            // iPhone X Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 812.0 {
            
                itemSize = CGSize(width: 180, height: 180)
            
            // iPhone Plus Size
            } else {
                itemSize = CGSize(width: 180, height: 180)
            }
        
        default: break
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
