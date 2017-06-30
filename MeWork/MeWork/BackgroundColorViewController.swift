//
//  BackgroundColorViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/30/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class BackgroundColorViewController: UIViewController {
    
    var childName: String?
    var tokenNumber: Int?
    var selectedColor: Color?
    var tokenBoard: TokenBoard?
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        return label
        
    }()
    
    lazy var colorPaletteView: UICollectionView = {
        
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        
        self.view.addSubview(collectionView)
        
        return collectionView
        
    }()
    
    convenience init(childName: String, numberOfTokens: Int) {
        self.init()
        self.childName = childName
        self.tokenNumber = numberOfTokens
    }
    
    convenience init(tokenBoard: TokenBoard) {
        self.init()
        self.tokenBoard = tokenBoard
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
