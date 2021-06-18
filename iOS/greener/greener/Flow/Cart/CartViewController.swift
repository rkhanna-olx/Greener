//
//  CartViewController.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import UIKit
import MVVMRB

protocol CartViewControllerDependencyProtocol {
    var cartCoordinator: CartCoodinatorProtocol { get }
}

protocol CartViewControllerProtocol{
}

class CartViewController: BaseViewController<CartViewControllerDependencyProtocol, CartViewModelProtocol, CartRouterProtocol>, CartViewControllerProtocol {
    
    @IBOutlet weak var tableView: GreenerTableView!
    @IBOutlet weak var addToCartContainerView: UIView!
    @IBOutlet weak var addToCartButton: GreenerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
    }
    
    private func setupInterface() {
        setupTableView()
        addToCartButton.customize()
        
        let itemsString = dependency.cartCoordinator.cartCount >= 1 ? "item" : "items"
        addToCartButton.setTitle("Proceed to Buy (\(dependency.cartCoordinator.cartCount) \(itemsString))", for: .normal)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = UITableView.automaticDimension;
        tableView.rowHeight = UITableView.automaticDimension;
        
        tableView.register(CartValueTableViewCell.nib, forCellReuseIdentifier: CartValueTableViewCell.reuseIdentifier)
        tableView.register(CartProductsTableViewCell.nib, forCellReuseIdentifier: CartProductsTableViewCell.reuseIdentifier)
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.section {
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: CartProductsTableViewCell.reuseIdentifier, for: indexPath)
            (cell as? CartProductsTableViewCell)?.setupCell(dependency.cartCoordinator)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: CartValueTableViewCell.reuseIdentifier, for: indexPath)
            (cell as? CartValueTableViewCell)?.setupCell(totalCost: viewModel.totalCost)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? 8 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return CGFloat(147 * dependency.cartCoordinator.cartCount) + 46
        default: return UITableView.automaticDimension
        }
    }
}
