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
    let imageGetter: ImageGetter?
    
    lazy var imageScrollView: ScrollAndCropImageView = {
        
        let scrollView = ScrollAndCropImageView()
        self.view.addSubview(scrollView)
        
        return scrollView
    }()
    
    lazy var cropBox: CropBox = {
        
        let box = CropBox()
        box.isHidden = true
        
        view.addSubview(box)
        
        return box
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
    
    init(imageURL: URL, imageGetter: ImageGetter = ImageGetter.sharedInstance) {
        self.imageURL = imageURL
        self.imageGetter = imageGetter
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            
            // iPad Pro 12.9 inch
            if ScreenSize.SCREEN_MAX_LENGTH == 1366.0 {
                scrollViewSetup(withWidth: 300, andTopConstant: 80)
                cropBoxSetup()
                saveButtonSetup(withFontSize: 28.0, height: 60, andTopConstant: 80)
            }
            
        case .phone:
            
            print("phone")
            
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let imageGetter = imageGetter {
            imageGetter.getImage(from: imageURL, completion: { [weak self] (result) in
                
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                    
                case .ok(let image):
                    
                    DispatchQueue.main.async {
                        strongSelf.imageScrollView.showImage(image)
                        strongSelf.cropBox.isHidden = false
                    }
                    
                case .error(let error): strongSelf.showAlert(withTitle: "Oops!", andMessage: "There was a problem \(error.localizedDescription)")
                    
                }
                
            })
        }
    }
    
    func scrollViewSetup(withWidth width: CGFloat, andTopConstant constant: CGFloat) {
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            imageScrollView.widthAnchor.constraint(equalToConstant: width),
            imageScrollView.heightAnchor.constraint(equalToConstant: width),
            imageScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
    }
    
    func cropBoxSetup() {
    
        cropBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cropBox.topAnchor.constraint(equalTo: imageScrollView.topAnchor),
            cropBox.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor),
            cropBox.leftAnchor.constraint(equalTo: imageScrollView.leftAnchor),
            cropBox.rightAnchor.constraint(equalTo: imageScrollView.rightAnchor
            )])
        
    }
    
    func saveButtonSetup(withFontSize fontSize: CGFloat,height: CGFloat, andTopConstant constant: CGFloat) {
        
        saveImageButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        NSLayoutConstraint.activate([
            saveImageButton.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: constant),
            saveImageButton.heightAnchor.constraint(equalToConstant: height),
            saveImageButton.widthAnchor.constraint(equalToConstant: 200),
            saveImageButton.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor)
            ])
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Navigation

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
