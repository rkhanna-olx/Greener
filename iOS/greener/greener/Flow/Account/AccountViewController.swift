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
}
