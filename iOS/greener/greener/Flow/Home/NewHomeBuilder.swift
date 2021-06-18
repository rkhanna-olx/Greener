//
//  NewHomeBuilder.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

class NewHomeBuilderDependency: Component<NewHomeDependencyProtocol>, NewHomeViewControllerDependencyProtocol, NewHomeViewModelDependencyProtocol, NewHomeRouterDependencyProtocol {
    
    var productDetailBuilder: ProductDetailBuilder {
        return ProductDetailBuilder(dependency: ProductDetailDependency())
    }
    
    var productService: ProductServiceProtocol {
        return API.productService()
    }
    
    var listingBuilder: ListingBuilder {
        return ListingBuilder(dependency: ListingDependency())
    }
}

final class NewHomeBuilder: Builder<NewHomeDependencyProtocol> {
    func build() -> NewHomeViewControllerProtocol? {
        guard let dependency = dependency else { return nil }
        
        let component = NewHomeBuilderDependency(dependency: dependency)
        let viewModel = NewHomeViewModel(dependency: component)
        let router = NewHomeRouter(dependency: component, viewModel: viewModel)
        let viewController = NewHomeViewController(dependency: component, viewModel: viewModel, router: router)
        return viewController
    }
}
