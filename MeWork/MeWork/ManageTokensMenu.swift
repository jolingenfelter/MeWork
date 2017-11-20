//
//  ManageTokensMenu.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/19/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

class ManageTokensMenu: UIViewController {
    
    lazy var deleteButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Delete Token", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(deleteToken), for: .touchUpInside)

        return button
        
    }()
    
    lazy var addTokenToTokenBoardButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Add Token to...", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addTokenToTokenBoard), for: .touchUpInside)
        
        return button
        
    }()
    
    lazy var separatorView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.black
        
        return view
        
    }()
    
    lazy var tokenBoardListPopover: TokenBoardListPopover = {
        let tokenBoardList = TokenBoardListPopover()
        tokenBoardList.delegate = self
        
        return tokenBoardList
    }()
    
    var token: Token?
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)
        
        addTokenToTokenBoardButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTokenToTokenBoardButton)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        
        // SeparatorView
        NSLayoutConstraint.activate([
            separatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        
        
        // DeleteButton
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: separatorView.topAnchor)])
        
        // AddTokenToTokenBoardButton
        NSLayoutConstraint.activate([
            addTokenToTokenBoardButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            addTokenToTokenBoardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addTokenToTokenBoardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addTokenToTokenBoardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Button Actions

extension ManageTokensMenu {
    
    @objc func deleteToken() {
        
        guard let token = token, let fileName = token.fileName else {
            return
        }
        
        managedObjectContext.delete(token)
        try? managedObjectContext.save()
        
        deleteFile(named: fileName)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addTokenToTokenBoard() {
        
        tokenBoardListPopover.preferredContentSize = CGSize(width: 150, height: 150)
        tokenBoardListPopover.modalPresentationStyle = .popover
        
        let popoverPresentationController = tokenBoardListPopover.popoverPresentationController! as UIPopoverPresentationController
        popoverPresentationController.permittedArrowDirections = [.left, .right]
        popoverPresentationController.delegate = self
        popoverPresentationController.sourceView = addTokenToTokenBoardButton
        let sourceRect = CGRect(x: addTokenToTokenBoardButton.center.x, y: addTokenToTokenBoardButton.frame.height/2, width: 0, height: 0)
        popoverPresentationController.sourceRect = sourceRect
        
        present(tokenBoardListPopover, animated: true, completion: nil)
    
    }
    
}

extension ManageTokensMenu: TokenBoardListPopoverDelegate {
    func didSelect(tokenBoard: TokenBoard) {
        tokenBoard.token = token
        try? managedObjectContext.save()
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate

extension ManageTokensMenu: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad: return UIModalPresentationStyle.popover
        default: return UIModalPresentationStyle.none
        }
    }
}






