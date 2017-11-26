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
    
    init(tokenBoard: TokenBoard) {
        self.tokenBoardViewModel = TokenBoardViewModel(tokenBoard: tokenBoard)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}










