//
//  CropBox.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/1/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreGraphics

class CropBox: UIView {

    override func draw(_ rect: CGRect) {
        
        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height
        let viewSize = self.frame.size
        
        let lineWidth: CGFloat = 2.0
        let drawingColor = UIColor.black
        let fillColor = UIColor.white
        
        UIGraphicsBeginImageContext(viewSize)
        
        fillColor.setFill()
        
        // Vertical Lines
        let vLine1 = UIBezierPath()
        let vLine2 = UIBezierPath()
        let vLine3 = UIBezierPath()
        let vLines = [vLine1, vLine2, vLine3]
        
        for var i in 1...(vLines.count - 1) {
            
            let line = vLines[i]
            line.lineWidth = lineWidth
            drawingColor.setStroke()
            
            let topPoint = CGPoint(x: CGFloat(i) * viewWidth/3, y: 0)
            let bottomPoint = CGPoint(x: CGFloat(i) * viewWidth/3, y: viewHeight)
            
            line.move(to: topPoint)
            line.addLine(to: bottomPoint)
            
            i += 1
        }
        
        // Horizontal Lines
        let hline1 = UIBezierPath()
        let hline2 = UIBezierPath()
        let hline3 = UIBezierPath()
        let hLines = [hline1, hline2, hline3]
        
        for var i in 1...(hLines.count - 1) {
            
            let line = hLines[i]
            line.lineWidth = lineWidth
            drawingColor.setStroke()
            
            let leftPoint = CGPoint(x: 0, y: CGFloat(i) * viewHeight/3)
            let rightPoint = CGPoint(x: viewWidth, y: CGFloat(i) * viewHeight/3)
            
            line.move(to: leftPoint)
            line.addLine(to: rightPoint)
            
            i += 1
        }
        
        
        let gridPath = UIBezierPath()
        gridPath.append(vLine1)
        gridPath.append(vLine2)
        gridPath.append(vLine3)
        gridPath.append(hline1)
        gridPath.append(hline2)
        gridPath.append(hline3)
        
        gridPath.stroke()
    
        UIGraphicsEndImageContext()
        
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .white
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

}
