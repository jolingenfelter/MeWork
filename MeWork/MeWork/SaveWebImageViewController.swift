//
//  SaveWebImageViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 7/13/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class SaveWebImageViewController: UIViewController {
    
    var tokenBoard: TokenBoard?
    let imageURL: URL
    
    lazy var cropScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        
        return scrollView
    }()
    
    lazy var previewImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imageView)
        
        return imageView
        
    }()
    
    lazy var saveImageButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.navBarBlue.color()
        button.setTitle("Save Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button

        
    }()
    
    init(imageURL: URL) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.yellow.color()
        navBarSetup()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            
            // iPad Pro 12.9 inch
            if ScreenSize.SCREEN_MAX_LENGTH == 1366.0 {
                scrollViewSetup(withWidth: 300, andTopConstant: 80)
                imagViewSetup()
                saveButtonSetup(withFontSize: 28.0, height: 60, andTopConstant: 80)
            }
            
        case .phone:
            
            print("phone")
            
        default:
            break
        }
    }
    
    func scrollViewSetup(withWidth width: CGFloat, andTopConstant constant: CGFloat) {
        
        cropScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cropScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            cropScrollView.widthAnchor.constraint(equalToConstant: width),
            cropScrollView.heightAnchor.constraint(equalToConstant: width),
            cropScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
    }
    
    func imagViewSetup() {
        
        previewImageView.backgroundColor = .blue
        
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: cropScrollView.topAnchor),
            previewImageView.widthAnchor.constraint(equalTo: cropScrollView.widthAnchor),
            previewImageView.heightAnchor.constraint(equalTo: cropScrollView.heightAnchor),
            previewImageView.centerXAnchor.constraint(equalTo: cropScrollView.centerXAnchor)
            ])
        
    }
    
    func saveButtonSetup(withFontSize fontSize: CGFloat,height: CGFloat, andTopConstant constant: CGFloat) {
        
        saveImageButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        NSLayoutConstraint.activate([
            saveImageButton.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: constant),
            saveImageButton.heightAnchor.constraint(equalToConstant: height),
            saveImageButton.widthAnchor.constraint(equalToConstant: 200),
            saveImageButton.centerXAnchor.constraint(equalTo: previewImageView.centerXAnchor)
            ])
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SaveWebImageViewController {
    
    func navBarSetup() {
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40.0))
        view.addSubview(navigationBar)
        let navItem = UINavigationItem()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        navItem.leftBarButtonItem = cancelButton
        navigationBar.items = [navItem]
        
    }
    
    @objc func cancelPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SaveWebImageViewController: UIScrollViewDelegate {
    
}
