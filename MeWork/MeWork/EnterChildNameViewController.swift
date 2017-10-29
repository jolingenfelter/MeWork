//
//  EnterChildNameViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/25/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class EnterChildNameViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        
        self.view.addSubview(label)
        
        return label
    
    }()
    
    lazy var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 20)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        self.view.addSubview(textField)
        
        return textField
        
    }()
    
    lazy var nextButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.navBarBlue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    var childName: String?
    var tokenBoard: TokenBoard?
    
    convenience init(tokenBoard: TokenBoard) {
        self.init()
        self.tokenBoard = tokenBoard
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.green.color()
        navBarSetup()
        prepareViewController()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareViewController() {
        
        if let tokenBoard = tokenBoard {
            
            childName = tokenBoard.childName
            nameTextField.text = tokenBoard.childName
            nextButton.setTitle("Save changes", for: .normal)
            titleLabel.text = "Update the name of this child or token board"
            
        } else {
            
            titleLabel.text = "What is the name of the child or title of this token board?"
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
            
        }
        
    }
    
    // MARK: - View Layout
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            setupTitleLabel(withFontSize: 48)
            setupTextField(withTopConstant: 300)
            setUpButton(withHeight: 60, andFontSize: 24)
        
        case .phone:
            
            setupTitleLabel(withFontSize: 24)
            setupTextField(withTopConstant: 100)
            setUpButton(withHeight: 40, andFontSize: 18)
            
        default: break
            
        }
    }
    
    func setupTitleLabel(withFontSize: CGFloat) {
        
        titleLabel.font = UIFont.systemFont(ofSize: withFontSize)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
            ])
        
    }
    
    func setupTextField(withTopConstant: CGFloat) {
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: withTopConstant),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    func setUpButton(withHeight: CGFloat, andFontSize: CGFloat) {
        
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: andFontSize)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: withHeight),
            nextButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40)
            ])
        
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
        
    }
    
    @objc func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func nextPressed() {
        
        guard nameTextField.text != "" else {
            
            showAlert(withTitle: "Oops!", andMessage: "Please enter the name of the child or a name for this tokenBoard")
            
            return
        }
        
        childName = nameTextField.text
        
        let tokensViewController = NumberOfTokensViewController(childName: childName!)
        navigationController?.pushViewController(tokensViewController, animated: true)
        
    }
    
    func savePressed() {
        
        guard nameTextField.text != "" else {
            
            showAlert(withTitle: "Oops!", andMessage: "Please enter the name of the child or a name for this tokenBoard")
            
            return
        }
        
        tokenBoard?.childName = nameTextField.text
        CoreDataManager.sharedInstance.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
