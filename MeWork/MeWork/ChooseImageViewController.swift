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
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        return label
        
    }()
    
    lazy var tokenImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    lazy var imageFromWebButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.blue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    lazy var imageFromMeWorkLibraryButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.blue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    lazy var imageFromPhotoLibraryButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.blue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
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
        prepareViewController()
        navBarSetup()

        // Do any additional setup after loading the view.
    }
    
    func prepareViewController() {
        
        if tokenBoard != nil {
            
            titleLabel.text = "Edit token image"
            
        } else {
            
            titleLabel.text = "Choose an image for this board's tokens"
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View Setup
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            setupLabel(withFontSize: 48)
            
        case .phone:
            
            setupLabel(withFontSize: 24)
            
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

}

// MARK: - Navigation

extension ChooseImageViewController {
    
    func navBarSetup() {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.setRightBarButtonItems([doneButton, cancelButton], animated: true)
        
    }
    
    func donePressed() {
        
        
    }
    
    func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}














