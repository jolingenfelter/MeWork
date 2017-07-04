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
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
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
        
        prepareViewController()

        // Do any additional setup after loading the view.
    }
    
    func prepareViewController() {
        
        if  let tokenBoard = tokenBoard {
            
            titleLabel.text = "Edit background color"
            selectedColor = Color(rawValue: tokenBoard.backgroundColor!)!
            view.backgroundColor = Color(rawValue: tokenBoard.backgroundColor!)!.color()
            
        } else {
            
            titleLabel.text = "Choose a background color"
            view.backgroundColor = Color.green.color()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            if DeviceType.IS_IPAD_PRO_12_9 {
                
                setupLabel(withFontSize: 60)
                setupCollectionView(withTopConstant: 80, andBottomConstant: 200)
                
            } else {
                
                setupLabel(withFontSize: 48)
                setupCollectionView(withTopConstant: 80, andBottomConstant: 120)
                
            }
            
        case .phone:
            
            setupLabel(withFontSize: 24)
            
            if DeviceType.IS_IPHONE_6P || DeviceType.IS_IPHONE_7P {
                
                setupCollectionView(withTopConstant: 60, andBottomConstant: 100)
                
            } else {
                
                setupCollectionView(withTopConstant: 40, andBottomConstant: 40)
                
            }
            
        default:
            
            break
            
        }
    }
    
    func setupLabel(withFontSize: CGFloat) {
        
        titleLabel.font = UIFont.systemFont(ofSize: withFontSize)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
            ])
        
    }
    
    func setupCollectionView(withTopConstant: CGFloat, andBottomConstant: CGFloat) {
        
        NSLayoutConstraint.activate([
            colorPaletteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorPaletteView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: withTopConstant),
            colorPaletteView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: andBottomConstant)
            ])

    }
    
}
