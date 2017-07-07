//
//  ColorCell.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 7/4/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCell"
    let colorSample = UIButton()
    var color: Color?
    
    override func layoutSubviews() {
        
        contentView.addSubview(colorSample)
        colorSample.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorSample.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorSample.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorSample.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorSample.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
    }
    
    func configureCell(forColor color: Color) {
        
        self.color = color
        colorSample.backgroundColor = color.color()
        colorSample.layer.cornerRadius = 15
        colorSample.layer.masksToBounds = true
        
    }
    
}
