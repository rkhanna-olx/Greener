//
//  ListingViewController.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import Foundation
import UIKit
import MVVMRB

protocol ListingViewControllerDependencyProtocol {
}

protocol ListingViewControllerProtocol{
}

class ListingViewController: ViewController<ListingViewControllerDependencyProtocol, ListingViewModelProtocol, ListingRouterProtocol>, ListingViewControllerProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
