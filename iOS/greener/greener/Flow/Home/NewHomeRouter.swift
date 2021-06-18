//
//  NewHomeRouter.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

protocol NewHomeRouterDependencyProtocol {
    var productDetailBuilder: ProductDetailBuilder { get }
    var listingBuilder: ListingBuilder { get }
}

protocol NewHomeRouterProtocol {
    func routeToProductDetail(_ id: Int, navigationController: UINavigationController)
    func routeToListing(navigationController: UINavigationController)
}

class NewHomeRouter: Router<NewHomeRouterDependencyProtocol, NewHomeViewModelProtocol>, NewHomeRouterProtocol {
    func routeToProductDetail(_ id: Int, navigationController: UINavigationController) {
        if let viewController = dependency.productDetailBuilder.build() as? ProductDetailViewController {
            viewController.routeTo(productId: id)
            viewController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func routeToListing(navigationController: UINavigationController) {
        if let viewController = dependency.listingBuilder.build() as? ListingViewController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
