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
    
    lazy var rewardImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        //getWebImageVC.delegate = self
        return getWebImageVC
    }()

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
                buttonSetup(withFontSize: 28, height: 80, topAnchorConstant: 180, bottomAnchorConstant: -220)
                
                // iPad Pro 10.5 inch
            } else if ScreenSize.SCREEN_MAX_LENGTH == 1112.0 {
                
                setupImageView(withHeight: 400, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 24, height: 60, topAnchorConstant: 80, bottomAnchorConstant: -180)
                
                // iPad 9.7 inch and mini
            } else {
                
                setupImageView(withHeight: 400, andTopAnchorConstant: 60)
                buttonSetup(withFontSize: 20, height: 50, topAnchorConstant: 80, bottomAnchorConstant: -120)
                
            }
            
            // Layout for iPhones
            
        case .phone:
            
            // iPhone 5 Size
            if ScreenSize.SCREEN_MAX_LENGTH == 568.0 {
                
                setupImageView(withHeight: 170, andTopAnchorConstant: 20)
                buttonSetup(withFontSize: 14, height: 40, topAnchorConstant: 40, bottomAnchorConstant: -40)
                
                // iPhone 6 Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 667 {
                
                setupImageView(withHeight: 180, andTopAnchorConstant: 20)
                buttonSetup(withFontSize: 16, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -80)
                
                // iPhone X Size
            } else if ScreenSize.SCREEN_MAX_LENGTH == 812.0 {
                
                setupImageView(withHeight: 260, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 40, bottomAnchorConstant: -120)
                
                // iPhone Plus Size
            } else {
                
                setupImageView(withHeight: 240, andTopAnchorConstant: 40)
                buttonSetup(withFontSize: 18, height: 40, topAnchorConstant: 80, bottomAnchorConstant: -80)
                
            }
            
        default:
            
            break
            
        }
        
        
    }

    
    func setupImageView(withHeight: CGFloat, andTopAnchorConstant: CGFloat) {
        
        rewardImageView.backgroundColor = UIColor.blue
        NSLayoutConstraint.activate([
            rewardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: andTopAnchorConstant),
            rewardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rewardImageView.heightAnchor.constraint(equalToConstant: withHeight),
            rewardImageView.widthAnchor.constraint(equalToConstant: withHeight)])
        
    }
    
    func buttonSetup(withFontSize: CGFloat, height: CGFloat, topAnchorConstant: CGFloat, bottomAnchorConstant: CGFloat) {
        
    }
    
    func navBarSetup() {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func imageFromWeb() {
        
    }
    
    @objc func imageFromPhotoLibrary() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Mark: - Navigation

extension ChooseRewardViewController {
    
    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
