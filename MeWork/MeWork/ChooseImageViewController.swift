//
//  ChooseImageViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/26/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ChooseImageViewController: UIViewController {
    
    var childName: String?
    var tokenNumber: Int?
    
    var tokenBoard: TokenBoard?
    
    convenience init(childName: String, tokenNumber: Int) {
        
        self.init()
        
        self.childName = childName
        self.tokenNumber = tokenNumber
        
    }
    
    convenience init(tokenBoard: TokenBoard) {
        
        self.init()
        
        self.tokenBoard = tokenBoard
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.green.color()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
