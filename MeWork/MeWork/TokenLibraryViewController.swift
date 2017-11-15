//
//  TokenLibraryViewController.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/13/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import CoreData

protocol TokenLibraryDelegate {
    func didSelectImageFromLibrary(_ image: UIImage)
}

class TokenLibraryViewController: UIViewController {
    
    var delegate: TokenLibraryDelegate!
    let managedObjectContext: NSManagedObjectContext
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        
        let controller = NSFetchedResultsController(fetchRequest: Token.allTokensFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return controller
    }()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.backgroundColor = Color.purple.color()
        
        return view
    }()
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            self.showAlert(withTitle: "Error", andMessage: "There was an error retrieving images: \(error.localizedDescription)")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let navigationController = self.navigationController else {
            return
        }
        
        let navigationBar = navigationController.navigationBar
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved Tokens"
        
        self.collectionView.register(TokenLibraryCell.self, forCellWithReuseIdentifier: TokenLibraryCell.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UICollectionViewDelegate & DataSource

extension TokenLibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let token = fetchedResultsController.object(at: indexPath) as! Token
        
        guard let image = retrieveImage(imageName: token.fileName!) else {
            return
        }
        
        delegate.didSelectImageFromLibrary(image)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TokenLibraryCell.reuseIdentifier, for: indexPath) as! TokenLibraryCell
        let token = fetchedResultsController.object(at: indexPath) as! Token
        let tokenImageName = token.fileName!
        
        if let tokenImage = UIImage(named: tokenImageName) {
            cell.configureCell(withImage: tokenImage)
        }
        
        return cell
    }
    
}
