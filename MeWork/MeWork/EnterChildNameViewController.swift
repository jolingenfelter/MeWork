//
//  EnterChildNameViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/25/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class EnterChildNameViewController: UIViewController {
    
    lazy var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textField)
        
        return textField
        
    }()
    
    lazy var nextButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = Color.blue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        return button
        
    }()
    
    var childName: String?

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

// MARK: - UITextFieldDelegate 

extension EnterChildNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nextPressed()
        
        return true
    }
    
}

// MARK: - Navigation

extension EnterChildNameViewController {
    
    func navBarSetup() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.rightBarButtonItem = cancelButton
        navigationItem.title = "Child Name"
        
    }
    
    func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func nextPressed() {
        
        guard nameTextField.text != "" else {
            
            showAlert(withTitle: "Oops!", andMessage: "Please enter the name of the child or a name for this tokenBoard")
            
            return
        }
        
        childName = nameTextField.text
        
    }
    
}
