//
//  RewardsLibraryViewController.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/20/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

class RewardsLibraryViewController: ManageTokensViewController {
    
    override lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let controller = NSFetchedResultsController(fetchRequest: Reward.allRewardsFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved Rewards"
        view.backgroundColor = Color.purple.color()
    }
    
    override func instructionsLabelSetup() {
        instructionsLabel.text = "There are no rewards in your library."
        instructionsLabel.textColor = .white
        instructionsLabel.textAlignment = .center
        setLabelFontSize()
        showInstructionsLabel()
    }
    
    override func navBarSetup() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TokenLibraryViewController.cancelPressed))
        let addRewardButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRewardPressed))
        
        navigationItem.rightBarButtonItems = [doneButton, addRewardButton]
    }
    
    @objc func addRewardPressed() {
        
    }

}

// MARK: - UICollectionViewDataSource & Delegate

extension RewardsLibraryViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let reward = fetchedResultsController.object(at: indexPath) as! Reward
        manageTokensMenu.reward = reward
        
        manageTokensMenu.modalPresentationStyle = .popover
        manageTokensMenu.preferredContentSize = CGSize(width: 150, height: 150)
        
        let popover = manageTokensMenu.popoverPresentationController! as UIPopoverPresentationController
        popover.delegate = self
        popover.permittedArrowDirections = [.left, .right]
        let cell = collectionView.cellForItem(at: indexPath) as! TokenLibraryCell
        popover.sourceView = cell
        popover.sourceRect = cell.imageView.frame
        
        self.present(manageTokensMenu, animated: true, completion: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TokenLibraryCell.reuseIdentifier, for: indexPath) as! TokenLibraryCell
        let reward = fetchedResultsController.object(at: indexPath) as! Reward
        
        guard let fileName = reward.fileName, let image = retrieveImage(imageName: fileName) else {
            cell.configureCell(withImage: UIImage(named: "NoImage")!)
            return cell
        }
        
        cell.configureCell(withImage: image)
        
        return cell
    }
    
}













