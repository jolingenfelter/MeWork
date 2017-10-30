//
//  HomeViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "MeWork"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        return label
        
    }()
    
    lazy var createTokenBoardButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Create or Edit Token Board", for: .normal)
        button.backgroundColor = Color.navBarBlue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(createTokenBoardPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    lazy var selectTokenBoardButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Select Token Board", for: .normal)
        button.backgroundColor = Color.navBarBlue.color()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(selectTokenBoardPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        return button
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.yellow.color()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        switch UIDevice.current.userInterfaceIdiom {
        
        case .phone:
            
            // Label
            setupLabelWithConstaints(andFontSize: 72)
            
            // Buttons
             setButtonConstraints(withLeadingAnchorConstant: 40, trailingAnchorConstant: -40, height: 50, topAnchor: view.centerYAnchor, topConstant: 40)
            
        case .pad:
            
            // Label
            setupLabelWithConstaints(andFontSize: 180)
            
            // Buttons
            setButtonConstraints(withLeadingAnchorConstant: 80, trailingAnchorConstant: -80, height: 80, topAnchor: view.centerYAnchor, topConstant: 40)
            createTokenBoardButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            selectTokenBoardButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        
        default:
            return
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Set Constraints
        // Methods to accommodate different screen sizes
    
    func setButtonConstraints(withLeadingAnchorConstant: CGFloat, trailingAnchorConstant: CGFloat, height: CGFloat, topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, topConstant: CGFloat) {
        
        // CreateTokenBoardButton
        
        NSLayoutConstraint.activate([
            createTokenBoardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: withLeadingAnchorConstant),
            createTokenBoardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingAnchorConstant),
            createTokenBoardButton.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            createTokenBoardButton.heightAnchor.constraint(equalToConstant: height)
            ])
        
        // SelectTokenBoardButton
        
        NSLayoutConstraint.activate([
            selectTokenBoardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: withLeadingAnchorConstant),
            selectTokenBoardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingAnchorConstant),
            selectTokenBoardButton.topAnchor.constraint(equalTo: createTokenBoardButton.bottomAnchor, constant: 30),
            selectTokenBoardButton.heightAnchor.constraint(equalToConstant: height)
            ])
        
    }
    
    func setupLabelWithConstaints(andFontSize: CGFloat) {
    
        titleLabel.font = UIFont.boldSystemFont(ofSize: andFontSize)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Button Outlets

extension HomeViewController {
    
    @objc func createTokenBoardPressed() {
        
        let tokenBoardListViewController = TokenBoardListViewController()
        navigationController?.pushViewController(tokenBoardListViewController, animated: true)
        
    }
    
    @objc func selectTokenBoardPressed() {
        
    }
    
}

