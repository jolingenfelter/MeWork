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
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate

extension TokenBoardListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
}
