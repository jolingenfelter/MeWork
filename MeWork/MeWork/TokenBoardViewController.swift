//
//  TokenBoardViewController.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/26/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class TokenBoardViewController: UIViewController {
    
    let tokenBoardViewModel: TokenBoardViewModel
    var tokenBoardView: TokenBoardView
    
    var workingForLabel = UILabel()
    var countLabel = UILabel()
    var rewardImageView = UIImageView()
    
    init?(tokenBoard: TokenBoard) {
        
        guard let tokenNumberString = tokenBoard.tokenNumber, let tokenNumber = Int(tokenNumberString), let token = tokenBoard.token, let tokenImageName = token.fileName, let tokenImage = UIImage(named: tokenImageName) else {
            return nil
        }
        self.tokenBoardViewModel = TokenBoardViewModel(tokenBoard: tokenBoard)
        self.tokenBoardView = TokenBoardView(tokenNumber: tokenNumber, tokenImage: tokenImage, frame: CGRect.zero)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(workingForLabel)
        workingForLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rewardImageView)
        rewardImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tokenBoardView)
        tokenBoardView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tokenBoardViewModel.configureView(self)
        self.title = tokenBoardViewModel.childName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TokenBoardViewController: TokenBoardModelView {
    
    var imageView: UIImageView {
        return rewardImageView
    }
    
    var tokenCountLabel: UILabel {
        return countLabel
    }
    
    var titleLabel: UILabel {
        return workingForLabel
    }
}










