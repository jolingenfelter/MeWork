//
//  BackgroundColorViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/30/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class BackgroundColorViewController: UIViewController {
    
    var childName: String?
    var tokenNumber: Int?
    var selectedColor: Color?
    var selectedColors: [ColorCell]?
    var tokenBoard: TokenBoard?
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        return label
        
    }()
    
    lazy var colorPaletteView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            if DeviceType.IS_IPAD_PRO_12_9 {
                
                flowLayout.estimatedItemSize = CGSize(width: 200, height: 200)
                
            } else {
                
                flowLayout.estimatedItemSize = CGSize(width: 150, height: 150)
                
            }
            
        case .phone:
            
            flowLayout.estimatedItemSize = CGSize(width: 60, height: 60)
            
        default:
            
            break
            
        }
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20)
        
        self.view.addSubview(collectionView)
        
        return collectionView
        
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
    
    convenience init(childName: String, numberOfTokens: Int) {
        self.init()
        self.childName = childName
        self.tokenNumber = numberOfTokens
    }
    
    convenience init(tokenBoard: TokenBoard) {
        self.init()
        self.tokenBoard = tokenBoard
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        
        prepareViewController()
        
        // Register CollectionViewCell
        colorPaletteView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        
        colorPaletteView.dataSource = self

    }
    
    func prepareViewController() {
        
        if  let tokenBoard = tokenBoard {
            
            titleLabel.text = "Edit background color"
            selectedColor = Color(rawValue: tokenBoard.backgroundColor!)!
            view.backgroundColor = Color(rawValue: tokenBoard.backgroundColor!)!.color()
            nextButton.setTitle("Save changes", for: .normal)
            nextButton.addTarget(self, action: #selector(saveChangesPressed), for: .touchUpInside)
            
        } else {
            
            titleLabel.text = "Choose a background color"
            view.backgroundColor = Color.green.color()
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            if DeviceType.IS_IPAD_PRO_12_9 {
                
                setupLabel(withFontSize: 60)
                setupCollectionView(withTopConstant: 80, andHeight: 500)
                setupNextButton(withFontSize: 28, height: 60, andTopConstant: 80)
                
            } else {
                
                setupLabel(withFontSize: 48)
                setupCollectionView(withTopConstant: 80, andHeight: 400)
                setupNextButton(withFontSize: 24, height: 60, andTopConstant: 60)
                
            }
            
        case .phone:
            
            setupLabel(withFontSize: 24)
            
            if DeviceType.IS_IPHONE_6P || DeviceType.IS_IPHONE_7P {
                
                setupCollectionView(withTopConstant: 60, andHeight: 300)
                setupNextButton(withFontSize: 18, height: 40, andTopConstant: 60)
                
            } else {
                
                setupCollectionView(withTopConstant: 40, andHeight: 250)
                setupNextButton(withFontSize: 22, height: 40, andTopConstant: 40)
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
    
    func setupCollectionView(withTopConstant: CGFloat, andHeight: CGFloat) {
        
        NSLayoutConstraint.activate([
            colorPaletteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorPaletteView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: withTopConstant),
            colorPaletteView.heightAnchor.constraint(equalToConstant: andHeight)
            ])

    }
    
    func setupNextButton(withFontSize: CGFloat, height: CGFloat, andTopConstant: CGFloat) {
        
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: withFontSize)
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: colorPaletteView.bottomAnchor, constant: andTopConstant),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: height)
            ])
        
    }
    
}

// MARK: - Navigation

extension BackgroundColorViewController {
    
    func navBarSetup() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        navigationItem.rightBarButtonItem = cancelButton
        
    }
    
    @objc func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func nextPressed() {
        
        guard let selectedColor = selectedColor else {
            
            showAlert(withTitle: "Oops!", andMessage: "Please select a background color for your token board")
            
            return
            
        }
        
        let chooseImageViewController = ChooseImageViewController(childName: childName!, tokenNumber: tokenNumber!, backgroundColor: selectedColor)
        
        navigationController?.pushViewController(chooseImageViewController, animated: true)
        
    }
    
    @objc func saveChangesPressed() {
        
        tokenBoard?.backgroundColor = selectedColor?.rawValue
        CoreDataManager.sharedInstance.saveContext()
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - UICollectionViewDataSource

extension BackgroundColorViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Color.allColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colorPaletteView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as! ColorCell
        let color = Color.allColors[indexPath.row]
        cell.configureCell(forColor: color)
        cell.colorSample.addTarget(self, action: #selector(toggleSelection(sender:)), for: .touchUpInside)
    
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension BackgroundColorViewController {
    
    @objc func toggleSelection(sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: colorPaletteView)
        
        guard let selectedIndexPath = colorPaletteView.indexPathForItem(at: point) else {
            return
        }
        
        let cell = colorPaletteView.cellForItem(at: selectedIndexPath) as! ColorCell
        
        cell.colorSample.layer.borderWidth = 4
        cell.colorSample.layer.borderColor = UIColor.lightGray.cgColor
        
        let color = Color.allColors[selectedIndexPath.row]
        view.backgroundColor = color.color()
        
        selectedColor = color
        
        let allCells = colorPaletteView.visibleCells as! [ColorCell]
        
        for cell in allCells {
            
            if cell.color != color {
                
                cell.colorSample.layer.borderWidth = 0
                
            }
        }
    
    }
    
}










