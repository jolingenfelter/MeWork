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
    
    var tokenImage: UIImage?
    var tokenImageName: String?
    
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        self.view.addSubview(imageView)
        
        return imageView
        
    }()
    
    lazy var imageFromWebButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.blue.color()
        button.setTitle("Image from the Web", for: .normal)
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
        button.setTitle("Image from MeWork Library", for: .normal)
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
        button.setTitle("Image from Photos", for: .normal)
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
        
        if let tokenBoard = tokenBoard {
            
            tokenImageName = tokenBoard.tokenImageName
            titleLabel.text = "Edit token image"
            
        } else {
            
            titleLabel.text = "Choose a token image"
            
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
            setupImageView(withHeight: 400, andTopAnchorConstant: 60)
            
            if DeviceType.IS_IPAD_PRO_12_9 {
                
                buttonSetup(withFontSize: 28, height: 80, topAnchorConstant: 180, bottomAnchorConstant: -180)
                
            } else {
                
                buttonSetup(withFontSize: 24, height: 60, topAnchorConstant: 80, bottomAnchorConstant: -120)
                
            }
            
        case .phone:
            
            setupLabel(withFontSize: 24)
            setupImageView(withHeight: 200, andTopAnchorConstant: 20)
            buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 20, bottomAnchorConstant: -40)
            
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
    
    func setupImageView(withHeight: CGFloat, andTopAnchorConstant: CGFloat) {
        
        tokenImageView.backgroundColor = .purple
        
        NSLayoutConstraint.activate([
            tokenImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: andTopAnchorConstant),
            tokenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenImageView.heightAnchor.constraint(equalToConstant: withHeight),
            tokenImageView.widthAnchor.constraint(equalTo: tokenImageView.heightAnchor)
            ])
        
    }
    
    func buttonSetup(withFontSize: CGFloat, height: CGFloat, topAnchorConstant: CGFloat, bottomAnchorConstant: CGFloat) {
        
        let buttonsArray = [imageFromWebButton, imageFromPhotoLibraryButton, imageFromMeWorkLibraryButton]
        
        let stackView = UIStackView(arrangedSubviews: buttonsArray)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        for button in buttonsArray {
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: withFontSize)
        
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: height)])
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            stackView.topAnchor.constraint(equalTo: tokenImageView.bottomAnchor, constant: topAnchorConstant),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomAnchorConstant)
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
        
        if tokenBoard == nil {
            
            guard let tokenImageName = tokenImageName else {
                
                showAlert(withTitle: "Oops!", andMessage: "You must choose an image for your tokens")
                
                return
            }
            
        } else {
            
            
            
        }
        
    }
    
    func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}














