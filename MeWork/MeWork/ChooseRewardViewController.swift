//
//  ChooseRewardViewController.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/20/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

protocol ChooseRewardDelegate {
    func didSelectReward(image: UIImage)
}

class ChooseRewardViewController: UIViewController {
    
    var delegate: ChooseRewardDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.yellow.color()
        navBarSetup()

        // Do any additional setup after loading the view.
    }
    
    func navBarSetup() {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Mark: - Navigation

extension ChooseRewardViewController {
    
    @objc func donePressed() {
        
    }
    
    @objc func cancelPressed() {
        
    }
}
