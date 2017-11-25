//
//  TokenLibraryCell.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/14/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class TokenLibraryCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(TokenLibraryCell.self)"
    
    lazy var imageView: UIImageView = {
        
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        
        return view
    }()
    
    override func layoutSubviews() {
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            ])
    }
    
    func configureCell(withImage: UIImage) {
        imageView.image = withImage
    }
    
}
