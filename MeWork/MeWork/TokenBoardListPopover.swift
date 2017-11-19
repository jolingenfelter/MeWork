//
//  TokenBoardListPopover.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/19/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

protocol TokenBoardListPopoverDelegate {
    func didSelect(tokenBoard: TokenBoard)
}

class TokenBoardListPopover: TokenBoardListViewController {
    
    var delegate: TokenBoardListPopoverDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tokenBoard = dataSource.fetchedResultsController.object(at: indexPath) as! TokenBoard
        delegate.didSelect(tokenBoard: tokenBoard)
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
