//
//  CartViewModel.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

protocol CartViewModelDependencyProtocol {
    var cartCoordinator: CartCoodinatorProtocol { get }
}

protocol CartViewModelProtocol {
    var totalCost: Int { get }
}

class CartViewModel: ViewModel<CartViewModelDependencyProtocol>, CartViewModelProtocol {
    var totalCost: Int { return dependency.cartCoordinator.cartTotalCost }
}
