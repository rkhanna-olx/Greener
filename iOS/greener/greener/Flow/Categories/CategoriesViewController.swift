//
//  CategoriesViewController.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import UIKit
import MVVMRB

protocol CategoriesViewControllerDependencyProtocol {
}

protocol CategoriesViewControllerProtocol{
}

class CategoriesViewController: BaseViewController<CategoriesViewControllerDependencyProtocol, CategoriesViewModelProtocol, CategoriesRouterProtocol>, CategoriesViewControllerProtocol {
}
