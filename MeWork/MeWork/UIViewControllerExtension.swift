//
//  UIViewControllerExtension.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/25/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
