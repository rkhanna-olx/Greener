//
//  BaseViewController.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import MVVMRB

class BaseViewController<DependencyType, ViewModelType, RouterType>: ViewController<DependencyType, ViewModelType, RouterType> {

    required init(dependency: DependencyType, viewModel: ViewModelType, router: RouterType, bundle: Bundle? = nil) {
        if bundle == nil {
            super.init(dependency: dependency, viewModel: viewModel, router: router, bundle: Bundle.main)
        } else {
            super.init(dependency: dependency, viewModel: viewModel, router: router, bundle: bundle)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseNavigationBar()
    }
    
    private func setupBaseNavigationBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension BaseViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

protocol RouterProtocol {
    
}
protocol ViewModelProtocol {
    
}

protocol ViewControllerProtocol {
    var view: UIView! { get }
}
