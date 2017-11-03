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
        scrollView.maximumZoomScale = 10.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        
        return scrollView
    }()
    
    let cropBox = CropBox()
    
    var cropArea: CGRect? {
        
        get {
            
            guard let image = previewImageView.image else {
                return nil
            }
            
            let factor = image.size.width/view.frame.width
            let scale = 1/cropScrollView.zoomScale
            let imageFrame = previewImageView.frame
            
            let x = (cropScrollView.contentOffset.x + cropBox.frame.origin.x - imageFrame.origin.x) * scale * factor
            
            let y = (cropScrollView.contentOffset.y + cropBox.frame.origin.y - imageFrame.origin.y) * scale * factor
            
            let width = cropBox.frame.size.width * scale * factor
            
            let height = cropBox.frame.size.height * scale * factor
            
            return CGRect(x: x, y: y, width: width, height: height)
            
        }
        
    }
    
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
                cropBoxSetup()
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
    
    func cropBoxSetup() {
        
        view.addSubview(cropBox)
        cropBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cropBox.topAnchor.constraint(equalTo: cropScrollView.topAnchor, constant: 50),
            cropBox.bottomAnchor.constraint(equalTo: cropScrollView.bottomAnchor, constant: -50),
            cropBox.leftAnchor.constraint(equalTo: cropScrollView.leftAnchor, constant: 50),
            cropBox.rightAnchor.constraint(equalTo: cropScrollView.rightAnchor, constant: -50)])
        
    }
    
    func imagViewSetup() {
        
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

extension SaveWebImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cropScrollView
    }
    
}


