//
//  ManageTokensViewController.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/17/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

class ManageTokensViewController: TokenLibraryViewController {
    
    lazy var  manageTokensMenu: ManageTokensMenu = {
        
        let menu = ManageTokensMenu()

        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let token = fetchedResultsController.object(at: indexPath) as! Token
        manageTokensMenu.token = token

        manageTokensMenu.modalPresentationStyle = .popover
        manageTokensMenu.preferredContentSize = CGSize(width: 150, height: 150)
        manageTokensMenu.popoverPresentationController?.permittedArrowDirections = .left

        let popover = manageTokensMenu.popoverPresentationController! as UIPopoverPresentationController
        popover.delegate = self
        let cell = collectionView.cellForItem(at: indexPath) as! TokenLibraryCell
        popover.sourceView = cell
        popover.sourceRect = cell.imageView.frame

        self.present(manageTokensMenu, animated: true, completion: nil)
        
    }

}

// MARK: - PopoverPresentationDelegate

extension ManageTokensViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad: return UIModalPresentationStyle.popover
        default: return UIModalPresentationStyle.none
        }
    }
}
