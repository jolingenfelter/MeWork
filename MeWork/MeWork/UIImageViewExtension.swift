//
//  UIImageViewExtension.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 10/31/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func imageFrame() -> CGRect {
        
        let imageViewSize = self.frame.size
        
        guard let imageSize = self.image?.size else {
            return CGRect.zero
        }
        
        let imageViewRatio = imageViewSize.width/imageViewSize.height
        let imageRatio = imageSize.width/imageSize.height
        
        if imageRatio < imageViewRatio {
            
            let scaleFactor = imageViewSize.height/imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
            
        } else {
            
            let scaleFactor = imageViewSize.width/imageSize.width
            let height = imageSize.height * scaleFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
            
        }
        
    }
    
}
