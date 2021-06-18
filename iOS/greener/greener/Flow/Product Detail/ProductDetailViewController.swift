//
//  ProductDetailViewController.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import UIKit
import MVVMRB

protocol ProductDetailViewControllerDependencyProtocol {
}

protocol ProductDetailViewControllerProtocol{
    func routeTo(productId: Int)
}

class ProductDetailViewController: BaseViewController<ProductDetailViewControllerDependencyProtocol, ProductDetailViewModelProtocol, ProductDetailRouterProtocol>, ProductDetailViewControllerProtocol {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addToCartContainerView: UIView!
    @IBOutlet weak var addToCartButton: GreenerButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupAddToCarButton()
    }
    
    private func setupInterface() {
        view.backgroundColor = .white
        setupTableView()
        setupRightNavigationBarButtons()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        tableView.register(ProductDetailInfoTableViewCell.nib, forCellReuseIdentifier: ProductDetailInfoTableViewCell.reuseIdentifier)
        tableView.register(ProductDetailTrustedInfoTableViewCell.nib, forCellReuseIdentifier: ProductDetailTrustedInfoTableViewCell.reuseIdentifier)
        tableView.register(ProductDetailAboutInfoTableViewCell.nib, forCellReuseIdentifier: ProductDetailAboutInfoTableViewCell.reuseIdentifier)
        tableView.register(ProductDetailSimilarListingsTableViewCell.nib, forCellReuseIdentifier: ProductDetailSimilarListingsTableViewCell.reuseIdentifier)
    }
    
    private func setupRightNavigationBarButtons() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchButtonClicked))
        let cartButton = getCartButton()
        
        self.navigationItem.rightBarButtonItems = [cartButton, searchButton]
        
    }
    
    private func getCartButton() -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: viewModel.cartIconName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cartButtonClicked))
    }
    
    private func setupAddToCarButton() {
        addToCartButton.customize()
        
        let shadowPath = UIBezierPath(rect: addToCartContainerView.bounds)
        addToCartContainerView.layer.masksToBounds = false
        addToCartContainerView.layer.shadowColor = UIColor.black.cgColor
        addToCartContainerView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        addToCartContainerView.layer.shadowOpacity = 0.1
        addToCartContainerView.layer.shadowPath = shadowPath.cgPath
    }
    
    @objc func searchButtonClicked() {
        
    }
    
    @objc func cartButtonClicked() {
        if let navigationController = self.navigationController {
            router.routeToCart(navigationController: navigationController)
        }
    }
    
    
    private func fetchData() {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        
        viewModel.fetchProductDetail { [weak self] success, error in
            self?.activityIndicator.stopAnimating()
            if success {
                self?.loadingView.isHidden = true
                self?.tableView.reloadData()
            } else {
                self?.showAlert(error?.localizedDescription ?? "Something went wrong")
            }
        }
    }
    
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        viewModel.userPressedAddToCart()
        setupRightNavigationBarButtons()
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        switch indexPath.section {
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTrustedInfoTableViewCell.reuseIdentifier, for: indexPath)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailAboutInfoTableViewCell.reuseIdentifier, for: indexPath)
            if let productData = viewModel.getProductData() {
                (cell as? ProductDetailAboutInfoTableViewCell)?.setupCell(with: productData)
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailSimilarListingsTableViewCell.reuseIdentifier, for: indexPath)
            if let productData = viewModel.getProductData(), let similar = productData.similar {
                (cell as? ProductDetailSimilarListingsTableViewCell)?.setupCell(with: similar)
                (cell as? ProductDetailSimilarListingsTableViewCell)?.delegate = self
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailInfoTableViewCell.reuseIdentifier, for: indexPath)
            if let productData = viewModel.getProductData() {
                (cell as? ProductDetailInfoTableViewCell)?.setupCell(with: productData)
            }
        }
        
        return cell
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 3:
            return 0
        default:
            return 8.0
        }
    }
}

extension ProductDetailViewController {
    func routeTo(productId: Int) {
        viewModel.setProductId(productId)
    }
}

extension ProductDetailViewController: ProductDetailSimilarListingsTableViewCellDelegate {
    func userDidSelectSimilarListing(cell: ProductDetailSimilarListingsTableViewCell, index: Int) {
        if let navigationController = self.navigationController, let productId = viewModel.getProductIdForEcofriendlyItem(at: index) {
            router.routeToProductDetail(productId, navigationController: navigationController)
        }
    }
}
