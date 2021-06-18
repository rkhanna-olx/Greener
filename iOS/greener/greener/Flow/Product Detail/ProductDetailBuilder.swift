//
//  ProductDetailBuilder.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import MVVMRB

class ProductDetailBuilderDependency: Component<ProductDetailDependencyProtocol>, ProductDetailViewControllerDependencyProtocol, ProductDetailViewModelDependencyProtocol, ProductDetailRouterDependencyProtocol {
    
    var productService: ProductServiceProtocol {
        return API.productService()
    }
    
    var productDetailBuilder: ProductDetailBuilder {
        return ProductDetailBuilder(dependency: ProductDetailDependency())
    }
    
    var cartCoordinator: CartCoodinatorProtocol {
        return CartCoodinator.sharedInstance
    }
    
    var cartBuilder: CartBuilder {
        return CartBuilder(dependency: CartDependency())
    }
}

final class ProductDetailBuilder: Builder<ProductDetailDependencyProtocol> {
    func build() -> ProductDetailViewControllerProtocol? {
        guard let dependency = dependency else { return nil }
        
        let component = ProductDetailBuilderDependency(dependency: dependency)
        let viewModel = ProductDetailViewModel(dependency: component)
        let router = ProductDetailRouter(dependency: component, viewModel: viewModel)
        let viewController = ProductDetailViewController(dependency: component, viewModel: viewModel, router: router)
        return viewController
    }
}
