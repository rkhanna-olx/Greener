//
//  CartBuilder.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

class CartBuilderDependency: Component<CartDependencyProtocol>, CartViewControllerDependencyProtocol, CartViewModelDependencyProtocol, CartRouterDependencyProtocol {
    var cartCoordinator: CartCoodinatorProtocol {
        return CartCoodinator.sharedInstance
    }
}

final class CartBuilder: Builder<CartDependencyProtocol> {
    func build() -> CartViewControllerProtocol? {
        guard let dependency = dependency else { return nil }
        
        let component = CartBuilderDependency(dependency: dependency)
        let viewModel = CartViewModel(dependency: component)
        let router = CartRouter(dependency: component, viewModel: viewModel)
        let viewController = CartViewController(dependency: component, viewModel: viewModel, router: router)
        return viewController
    }
}
