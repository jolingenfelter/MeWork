//
//  NumberOfTokensViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/26/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class NumberOfTokensViewController: UIViewController {
    
    var tokenBoard: TokenBoard?
    var childName: String?
    let tokenNumber = [Int](1...10)
    var selectedNumberOfTokens: Int?
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        return label
        
    }()
    
    lazy var pickerView: UIPickerView = {
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pickerView)
        
        return pickerView
        
    }()
    
    lazy var nextButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = Color.blue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    convenience init(tokenBoard: TokenBoard) {
        self.init()
        self.tokenBoard = tokenBoard
    }
    
    convenience init(childName: String) {
        self.init()
        self.childName = childName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
        view.backgroundColor = Color.green.color()
        navBarSetup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View Layout
    
    func prepareViewController() {
        
        if let tokenBoard = tokenBoard {
    
            selectedNumberOfTokens = Int(tokenBoard.tokenNumber!)
            pickerView.selectRow(tokenNumber[selectedNumberOfTokens!], inComponent: 0, animated: true)
            titleLabel.text = "Edit number of tokens"
            nextButton.setTitle("Save changes", for: .normal)
            nextButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
            
        } else {
            
            selectedNumberOfTokens = tokenNumber[pickerView.selectedRow(inComponent: 0)]
            titleLabel.text = "How many tokens?"
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)

            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            if DeviceType.IS_IPAD_PRO_12_9 {
                
                setupLabel(withFontSize: 60)
                setupPickerView(withTopConstant: 80, andHeight: 500)
                setupNextButton(withFontSize: 28, height: 60, andTopConstant: 80)
                
            } else {
                
                setupLabel(withFontSize: 48)
                setupPickerView(withTopConstant: 80, andHeight: 400)
                setupNextButton(withFontSize: 24, height: 60, andTopConstant: 60)
                
            }
            
        case .phone:
            
            setupLabel(withFontSize: 24)
            
            if DeviceType.IS_IPHONE_7P || DeviceType.IS_IPHONE_6P {
                
                setupPickerView(withTopConstant: 60, andHeight: 300)
                setupNextButton(withFontSize: 22, height: 40, andTopConstant: 60)
                
            } else {
                
                setupPickerView(withTopConstant: 40, andHeight: 250)
                setupNextButton(withFontSize: 18, height: 40, andTopConstant: 40)
                
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
    
    func setupPickerView(withTopConstant: CGFloat, andHeight: CGFloat) {
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: withTopConstant),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: andHeight)
            ])
        
    }
    
    func setupNextButton(withFontSize: CGFloat, height: CGFloat, andTopConstant: CGFloat) {
        
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: withFontSize)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: andTopConstant),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: height)
            ])
        
    }
    
}

// MARK: - Navigation 

extension NumberOfTokensViewController {
    
    
    func navBarSetup() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        navigationItem.rightBarButtonItem = cancelButton
        
    }
    
    func cancelPressed() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func nextPressed() {
    
        let backgroundColorViewController = BackgroundColorViewController(childName: childName!, numberOfTokens: selectedNumberOfTokens!)
        navigationController?.pushViewController(backgroundColorViewController, animated: true)
        
    }
    
    func savePressed() {
        
        tokenBoard?.tokenNumber = String(describing: selectedNumberOfTokens)
        CoreDataManager.sharedInstance.saveContext()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

// MARK: - UIPickerViewDelegate

extension NumberOfTokensViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumberOfTokens = tokenNumber[row]
    }
    
}

// MARK: - UIPickerView DataSource

extension NumberOfTokensViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: tokenNumber[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tokenNumber.count
    }
    
}
