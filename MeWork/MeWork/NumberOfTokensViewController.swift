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
            titleLabel.text = "How many tokens on this board?"
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)

            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .pad:
            
            setupLabel(withFontSize: 48)
            setupPickerView()
            setupNextButton(withFontSize: 24, andHeight: 60)
            
        case .phone:
            
            setupLabel(withFontSize: 24)
            setupPickerView()
            setupNextButton(withFontSize: 18, andHeight: 40)
            
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
    
    func setupPickerView() {
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            pickerView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor
            )])
        
    }
    
    func setupNextButton(withFontSize: CGFloat, andHeight: CGFloat) {
        
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: withFontSize)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: andHeight)
            ])
        
    }
    
}

// MARK: - Navigation 

extension NumberOfTokensViewController {
    
    func nextPressed() {
    
        let chooseImageViewController = ChooseImageViewController(childName: childName!, tokenNumber: selectedNumberOfTokens!)
        navigationController?.pushViewController(chooseImageViewController, animated: true)
        
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
