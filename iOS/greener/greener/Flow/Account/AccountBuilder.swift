//
//  AccountBuilder.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

class AccountBuilderDependency: Component<AccountDependencyProtocol>, AccountViewControllerDependencyProtocol, AccountViewModelDependencyProtocol, AccountRouterDependencyProtocol {
}

final class AccountBuilder: Builder<AccountDependencyProtocol> {
    func build() -> AccountViewControllerProtocol? {
        guard let dependency = dependency else { return nil }
        
        let component = AccountBuilderDependency(dependency: dependency)
        let viewModel = AccountViewModel(dependency: component)
        let router = AccountRouter(dependency: component, viewModel: viewModel)
        let viewController = AccountViewController(dependency: component, viewModel: viewModel, router: router)
        return viewController
    }
}
