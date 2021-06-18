//
//  CategoriesBuilder.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

class CategoriesBuilderDependency: Component<CategoriesDependencyProtocol>, CategoriesViewControllerDependencyProtocol, CategoriesViewModelDependencyProtocol, CategoriesRouterDependencyProtocol {
}

final class CategoriesBuilder: Builder<CategoriesDependencyProtocol> {
    func build() -> CategoriesViewControllerProtocol? {
        guard let dependency = dependency else { return nil }
        
        let component = CategoriesBuilderDependency(dependency: dependency)
        let viewModel = CategoriesViewModel(dependency: component)
        let router = CategoriesRouter(dependency: component, viewModel: viewModel)
        let viewController = CategoriesViewController(dependency: component, viewModel: viewModel, router: router)
        return viewController
    }
}
