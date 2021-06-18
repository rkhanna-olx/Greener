//
//  NewHomeViewController.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import UIKit
import MVVMRB

protocol NewHomeViewControllerDependencyProtocol {
}

protocol NewHomeViewControllerProtocol{
}

class NewHomeViewController: BaseViewController <NewHomeViewControllerDependencyProtocol, NewHomeViewModelProtocol, NewHomeRouterProtocol>, NewHomeViewControllerProtocol {
    
    @IBOutlet weak var searchView: GreenerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        viewModel.fetchEcofriendlyItem { success in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupInterface() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(HotDealsTableViewCell.nib, forCellReuseIdentifier: HotDealsTableViewCell.reuseIdentifier)
        tableView.register(ProductDetailSimilarListingsTableViewCell.nib, forCellReuseIdentifier: ProductDetailSimilarListingsTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        addShadowToSearchView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func addShadowToSearchView() {
        let shadowPath = UIBezierPath(roundedRect: searchView.bounds, cornerRadius: searchView.cornerRadius).cgPath
        searchView.layer.masksToBounds = false
        searchView.layer.shadowColor = UIColor.black.cgColor
        searchView.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchView.layer.shadowOpacity = 0.2
        searchView.layer.shadowRadius = 3.0
        searchView.layer.shadowPath = shadowPath
    }
}

extension NewHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: HotDealsTableViewCell.reuseIdentifier, for: indexPath) as! HotDealsTableViewCell
        switch indexPath.row {
        case 2:
            (cell as? HotDealsTableViewCell)?.setupCell(type: .imageOnly, data: viewModel.hotDealsData)
        case 1:
            (cell as? HotDealsTableViewCell)?.setupCell(type: .roundedImageWithText, data: viewModel.productCategoriesData, title: "I am looking for")
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailSimilarListingsTableViewCell.reuseIdentifier, for: indexPath)
            (cell as? ProductDetailSimilarListingsTableViewCell)?.setupCell(with: viewModel.ecofriendlyItems, title: "Most ecofriendly items")
            (cell as? ProductDetailSimilarListingsTableViewCell)?.delegate = self
            (cell as? ProductDetailSimilarListingsTableViewCell)?.setTitleLabelFont(UIFont(name: "Metropolis-Bold", size: 16))
        }
        
        return cell
    }
}

extension NewHomeViewController: ProductDetailSimilarListingsTableViewCellDelegate {
    func userDidSelectSimilarListing(cell: ProductDetailSimilarListingsTableViewCell, index: Int) {
        if let navigationController = self.navigationController, let productId = viewModel.getProductIdForEcofriendlyItem(at: index) {
            router.routeToProductDetail(productId, navigationController: navigationController)
        }
    }
}

extension NewHomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, text.count > 0, let navigationController = self.navigationController {
            router.routeToListing(navigationController: navigationController)
        }
        
        return true
    }
}
