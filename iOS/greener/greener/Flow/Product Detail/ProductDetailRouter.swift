//
//  ProductDetailRouter.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import MVVMRB

protocol ProductDetailRouterDependencyProtocol {
    var productDetailBuilder: ProductDetailBuilder { get }
    var cartBuilder: CartBuilder { get }
}

protocol ProductDetailRouterProtocol {
    func routeToProductDetail(_ id: Int, navigationController: UINavigationController)
    func routeToCart(navigationController: UINavigationController)
}

class ProductDetailRouter: Router<ProductDetailRouterDependencyProtocol, ProductDetailViewModelProtocol>, ProductDetailRouterProtocol {
    func routeToProductDetail(_ id: Int, navigationController: UINavigationController) {
        if let viewController = dependency.productDetailBuilder.build() as? ProductDetailViewController {
            viewController.routeTo(productId: id)
            viewController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func routeToCart(navigationController: UINavigationController) {
        if let viewController = dependency.cartBuilder.build() as? CartViewController {
            viewController.hidesBottomBarWhenPushed = false
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
