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
    var backgroundColor: Color?
    var tokenBoard: TokenBoard?
    var tokenImage: UIImage?
    var tokenImageName: String?
    
    lazy var getWebImageViewController:  GetWebImageViewController = {
        let getWebImageVC = GetWebImageViewController()
        getWebImageVC.delegate = self
        return getWebImageVC
    }()
    
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
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(imageView)
        
        return imageView
        
    }()
    
    lazy var imageFromWebButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.navBarBlue.color()
        button.setTitle("Image from the Web", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(imageFromWeb), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    lazy var imageFromMeWorkLibraryButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.navBarBlue.color()
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
        button.backgroundColor = Color.navBarBlue.color()
        button.setTitle("Image from Photos", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(imageFromPhotoLibrary), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    lazy var mediaPickerManager: MediaPickerManager = {
        let manager = MediaPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    lazy var cropImageViewController: CropImageViewController = {
        let cropImageVC = CropImageViewController(imageLocation: ImageLocation.photoLibrary)
        cropImageVC.delegate = self
        return cropImageVC
    }()
    
    convenience init(childName: String, tokenNumber: Int, backgroundColor: Color) {
        
        self.init()
        
        self.childName = childName
        self.tokenNumber = tokenNumber
        self.backgroundColor = backgroundColor
        
    }
    
    convenience init(tokenBoard: TokenBoard) {

        self.init()
        
        self.tokenBoard = tokenBoard
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForTokenImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.green.color()
        prepareViewController()
        navBarSetup()
        
    }
    
    func prepareViewController() {
        
        if let tokenBoard = tokenBoard {
            
            tokenImageName = tokenBoard.tokenImageName
            titleLabel.text = "Edit token image"
            view.backgroundColor = Color(rawValue: tokenBoard.backgroundColor!)!.color()
            
        } else {
            
            titleLabel.text = "Choose a token image"
            view.backgroundColor = backgroundColor!.color()
            
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
          
        // Layout for iPads
            
        case .pad:
            
            // iPad Pro 12.9 inch
            if ScreenSize.SCREEN_MAX_LENGTH == 1366.0 {
                
                setupLabel(withFontSize: 48)
                setupImageView(withHeight: 440, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 28, height: 80, topAnchorConstant: 180, bottomAnchorConstant: -220)
            
            // iPad Pro 10.5 inch
            } else if ScreenSize.SCREEN_MAX_LENGTH == 1112.0 {
                
                setupLabel(withFontSize: 44)
                setupImageView(withHeight: 400, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 24, height: 60, topAnchorConstant: 80, bottomAnchorConstant: -180)
        
            // iPad 9.7 inch and mini
            } else {
                
                setupLabel(withFontSize: 40)
                setupImageView(withHeight: 400, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 20, height: 50, topAnchorConstant: 80, bottomAnchorConstant: -120)
                
            }
            
        // Layout for iPhones
            
        case .phone:
            
            // iPhone 5 Size
            if ScreenSize.SCREEN_MAX_LENGTH == 568.0 {
                
                setupLabel(withFontSize: 22)
                setupImageView(withHeight: 170, andTopAnchorConstant: 20)
                buttonSetup(withFontSize: 14, height: 40, topAnchorConstant: 40, bottomAnchorConstant: -40)
            
            // iPhone 6 Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 667 {
                
                setupLabel(withFontSize: 24)
                setupImageView(withHeight: 180, andTopAnchorConstant: 20)
                buttonSetup(withFontSize: 16, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -80)
            
            // iPhone X Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 812.0 {
                
                setupLabel(withFontSize: 32)
                setupImageView(withHeight: 260, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 40, bottomAnchorConstant: -120)
            
            // iPhone Plus Size
            } else {
                
                setupLabel(withFontSize: 30)
                setupImageView(withHeight: 240, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -80)
                
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
    
    func setupImageView(withHeight: CGFloat, andTopAnchorConstant: CGFloat) {
        
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
    
    func checkForTokenImage() {
        if let tokenImage = tokenImage {
            tokenImageView.image = tokenImage
        } else {
            let noImage = UIImage(named: "noImageIcon")!
            tokenImageView.image = noImage
        }
    }

}

// MARK: - Navigation

extension ChooseImageViewController {
    
    func navBarSetup() {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.setRightBarButtonItems([doneButton, cancelButton], animated: true)
        
    }
    
    @objc func donePressed() {
        
        guard let tokenImage = tokenImage else {
            showAlert(withTitle: "Oops!", andMessage: "You must choose an image for your tokens")
            return
        }
        
        let imageData = UIImageJPEGRepresentation(tokenImage, 1.0)
        let imageName = generateImageName()
        let fileName = getDocumentsDirectory().appendingPathComponent("\(imageName).jpeg")
        
        // Save Image to FileDirectory
        do {
            try imageData?.write(to: fileName)
            tokenImageName = imageName
        } catch let error {
            showAlert(withTitle: "Error", andMessage: "There was an error saving the image: \(error.localizedDescription)")
        }
        
        // Save TokenBoard to CoreData
        if let tokenBoard = tokenBoard {

            tokenBoard.tokenImageName = tokenImageName
            CoreDataManager.sharedInstance.saveContext()
            self.dismiss(animated: true, completion: nil)
        
       } else {
            
            guard let tokenImageName = tokenImageName else {
                return
            }
        
            tokenBoard = TokenBoard.tokenBoard(withName: childName!, backgroundColor: (backgroundColor?.rawValue)!, tokenImageName: tokenImageName, andTokenNumber: tokenNumber!)
            CoreDataManager.sharedInstance.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func cancelPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageFromWeb() {
        let navigationController = UINavigationController(rootViewController: getWebImageViewController)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    @objc func imageFromPhotoLibrary() {
        mediaPickerManager.presentImagePickerController(animated: true)
    }
}

// MARK: - GetWebImageDelegate

extension ChooseImageViewController: GetWebImageDelegate {
    
    func didGet(croppedWebImage: UIImage) {
        tokenImageView.image = croppedWebImage
        tokenImage = croppedWebImage
    }
    
}

// MARK: - MediaPickerManager

extension ChooseImageViewController: MediaPickerManagerDelegate {
    func mediaPickerManager(manager: MediaPickerManager, didFinishPickingImage image: UIImage) {
        mediaPickerManager.dismissImagePickerController(animated: true) {
            
            let navigationController = UINavigationController(rootViewController: self.cropImageViewController)
            self.cropImageViewController.originalImage = image
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}

extension ChooseImageViewController: CropImageDelegate {
    func didSelectAndCrop(image: UIImage) {
        
    }
}











