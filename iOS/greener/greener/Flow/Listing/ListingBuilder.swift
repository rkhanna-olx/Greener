//
//  ListingBuilder.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import Foundation
import MVVMRB

class ListingBuilderDependency: Component<ListingDependencyProtocol>, ListingViewControllerDependencyProtocol, ListingViewModelDependencyProtocol, ListingRouterDependencyProtocol {
}

final class ListingBuilder: Builder<ListingDependencyProtocol> {
    func build() -> ListingViewControllerProtocol? {
        guard let dependency = dependency else { return nil }
        
        let component = ListingBuilderDependency(dependency: dependency)
        let viewModel = ListingViewModel(dependency: component)
        let router = ListingRouter(dependency: component, viewModel: viewModel)
        let viewController = ListingViewController(dependency: component, viewModel: viewModel, router: router)
        return viewController
    }
}
