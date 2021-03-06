//
//  AccountViewController.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import UIKit
import MVVMRB

protocol AccountViewControllerDependencyProtocol {
}

protocol AccountViewControllerProtocol{
}

class AccountViewController: BaseViewController<AccountViewControllerDependencyProtocol, AccountViewModelProtocol, AccountRouterProtocol>, AccountViewControllerProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
