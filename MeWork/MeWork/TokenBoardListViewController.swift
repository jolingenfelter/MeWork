//
//  TokenBoardListViewController.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class TokenBoardListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
        
    }()
    
    lazy var dataSource: TokenBoardDataSource = {
        
        let controller = TokenBoardFetchedResultsController(fetchRequest: TokenBoard.allTokenBoardsRequest, managedObjectContext: CoreDataManager.sharedInstance.managedObjectContext, tableView: self.tableView)
        
        let source = TokenBoardDataSource(fetchedResultsController: controller, tableView: self.tableView)
        
        return source
        
    }()
    
    lazy var instructionsLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Tap + to create a new token board"
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = tableView
        tableView.dataSource = dataSource
        showInstructions()
        navigationBarSetup()

        NotificationCenter.default.addObserver(self, selector: #selector(showInstructions), name: NSNotification.Name(rawValue: "CheckForZeroTokenBoards"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "CheckForZeroTokenBoards"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        switch UIDevice.current.userInterfaceIdiom {
            
            case .pad:
            
                instructionsLabel(withFontSize: 48)
            
            case .phone:
            
                instructionsLabel(withFontSize: 18)
            
            default: break
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate

extension TokenBoardListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tokenBoard = dataSource.fetchedResultsController.object(at: indexPath) as! TokenBoard
        print(tokenBoard.token!.fileName as Any)
    }
    
}

// MARK: - Navigation

extension TokenBoardListViewController {
    
    func navigationBarSetup() {
        
        let addTokenBoardButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTokenBoardPressed))
        
        navigationItem.rightBarButtonItem = addTokenBoardButton
        
    }
    
    @objc func addTokenBoardPressed() {
        
        let childNameViewController = EnterChildNameViewController()
        let navigationController = UINavigationController(rootViewController: childNameViewController)
        
        self.present(navigationController, animated: true, completion: nil)
        
    }
}

// MARK: - Instructions Label 

extension TokenBoardListViewController {
    
    func instructionsLabel(withFontSize: CGFloat) {
        
        instructionsLabel.font = UIFont.systemFont(ofSize: withFontSize)
        
        NSLayoutConstraint.activate([
            instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
    }
    
    @objc func showInstructions() {
        
        if dataSource.fetchedResultsController.fetchedObjects?.count == 0 {
            
            instructionsLabel.isHidden = false
            
        } else {
            
            instructionsLabel.isHidden = true
            
        }
        
    }
    
}





