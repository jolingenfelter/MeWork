//
//  ChooseRewardViewController.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/20/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

protocol ChooseRewardDelegate {
    func didSelectReward(image: UIImage)
}

class ChooseRewardViewController: UIViewController {
    
    let managedObjectContext: NSManagedObjectContext
    
    var delegate: ChooseRewardDelegate!
    
    var rewardImage: UIImage?
    var rewardImageName: String?
    var reward: Reward?
    
    lazy var rewardImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    lazy var getWebImageViewController:  GetWebImageViewController = {
        let getWebImageVC = GetWebImageViewController()
        getWebImageVC.delegate = self
        return getWebImageVC
    }()
    
    lazy var mediaPickerManager: MediaPickerManager = {
        let manager = MediaPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForRewardImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.yellow.color()
        navBarSetup()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
            // Layout for iPads
            
        case .pad:
            
            // iPad Pro 12.9 inch
            if ScreenSize.SCREEN_MAX_LENGTH == 1366.0 {
                
                setupImageView(withHeight: 440, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 28, height: 80, topAnchorConstant: 180, bottomAnchorConstant: -400)
                
                // iPad Pro 10.5 inch
            } else if ScreenSize.SCREEN_MAX_LENGTH == 1112.0 {
                
                setupImageView(withHeight: 400, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 24, height: 60, topAnchorConstant: 80, bottomAnchorConstant: -360)
                
                // iPad 9.7 inch and mini
            } else {
                
                setupImageView(withHeight: 400, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 20, height: 50, topAnchorConstant: 80, bottomAnchorConstant: -280)
                
            }
            
            // Layout for iPhones
            
        case .phone:
            
            // iPhone 5 Size
            if ScreenSize.SCREEN_MAX_LENGTH == 568.0 {
                
                setupImageView(withHeight: 170, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 14, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -120)
                
                // iPhone 6 Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 667.0 {
                
                setupImageView(withHeight: 180, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 16, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -200)
                
                // iPhone X Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 812.0 {
                
                setupImageView(withHeight: 260, andTopAnchorConstant: 80)
                buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -200)
                
                // iPhone Plus Size
            } else {
                
                setupImageView(withHeight: 240, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -200)
                
            }
            
        default:
            
            break
            
        }
        
        
    }

    
    func setupImageView(withHeight: CGFloat, andTopAnchorConstant: CGFloat) {
        
        NSLayoutConstraint.activate([
            rewardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: andTopAnchorConstant),
            rewardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rewardImageView.heightAnchor.constraint(equalToConstant: withHeight),
            rewardImageView.widthAnchor.constraint(equalToConstant: withHeight)])
        
    }
    
    func buttonSetup(withFontSize: CGFloat, height: CGFloat, topAnchorConstant: CGFloat, bottomAnchorConstant: CGFloat) {
        
        let buttonsArray = [imageFromWebButton, imageFromPhotoLibraryButton]
        
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
            stackView.topAnchor.constraint(equalTo: rewardImageView.bottomAnchor, constant: topAnchorConstant),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomAnchorConstant)
            ])
        
    }
    
    func navBarSetup() {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func imageFromWeb() {
        let navigationController = UINavigationController(rootViewController: getWebImageViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func imageFromPhotoLibrary() {
        mediaPickerManager.presentImagePickerController(animated: true)
    }
    
    func checkForRewardImage() {
        if let rewardImage = rewardImage {
            rewardImageView.contentMode = .scaleAspectFit
            rewardImageView.image = rewardImage
        } else {
            let noImage = UIImage(named: "NoImage")!
            rewardImageView.contentMode = .scaleToFill
            rewardImageView.image = noImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Mark: - Navigation

extension ChooseRewardViewController {
    
    @objc func donePressed() {
        
        guard let rewardImage = rewardImage else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        let imageData = UIImageJPEGRepresentation(rewardImage, 1.0)
        let imageName = generateImageName()
        let fileName = getDocumentsDirectory().appendingPathComponent("\(imageName).jpeg")
        
        reward = Reward.reward(withName: imageName)
        
        // Save Image to FileDirectory
        do {
            try imageData?.write(to: fileName)
            rewardImageName = imageName
            try managedObjectContext.save()
        } catch let error {
            showAlert(withTitle: "Error", andMessage: "There was an error saving the image: \(error.localizedDescription)")
        }
        
        self.dismiss(animated: true) {
            self.rewardImageName = nil
            self.rewardImage = nil
            self.reward = nil
            self.rewardImageView.image = nil
        }
    }
    
}

// MARK: - GetWebImageDelegate

extension ChooseRewardViewController: GetWebImageDelegate {
    func didGet(croppedWebImage: UIImage) {
        rewardImage = croppedWebImage
        rewardImageView.image = croppedWebImage
    }
}

// MARK: - MediaPickerManagerDelegate

extension ChooseRewardViewController: MediaPickerManagerDelegate {
    func mediaPickerManager(manager: MediaPickerManager, didFinishPickingImage image: UIImage) {
        rewardImage = image
        rewardImageView.image = image
    }
}
