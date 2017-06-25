//
//  EnterChildNameViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/25/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class EnterChildNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.green.color()
        navBarSetup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Navigation

extension EnterChildNameViewController {
    
    func navBarSetup() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.rightBarButtonItem = cancelButton
        
    }
    
    func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
