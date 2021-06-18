//
//  ProductDetailViewModel.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import MVVMRB

protocol ProductDetailViewModelDependencyProtocol {
    var productService: ProductServiceProtocol { get }
    
    var cartCoordinator: CartCoodinatorProtocol { get }
}

protocol ProductDetailViewModelProtocol {
    func setProductId(_ id: Int)
    func fetchProductDetail(completion: @escaping (Bool, Error?) -> Void)
    func getProductData() -> ProductDTOProtocol?
    func getProductIdForEcofriendlyItem(at index: Int) -> Int?
    var cartIconName: String { get }
    var selectedQuantity: Int { get set }
    
    func userPressedAddToCart()
}

class ProductDetailViewModel: ViewModel<ProductDetailViewModelDependencyProtocol>, ProductDetailViewModelProtocol {
    
    var productId: Int?
    private var productData: ProductDTOProtocol?
    var selectedQuantity: Int = 1
    
    func fetchProductDetail(completion: @escaping (Bool, Error?) -> Void) {
        if let productId = productId {
            dependency.productService.fetchProductDetail(productId) { [weak self] data, error in
                self?.productData = data
                completion(error == nil, error)
            }
        }
    }
    
    func setProductId(_ id: Int) {
        productId = id
    }
    
    func getProductData() -> ProductDTOProtocol? {
        return productData
    }
    
    func getProductIdForEcofriendlyItem(at index: Int) -> Int? {
        guard let similar = productData?.similar, index < similar.count else { return nil }
        return similar[index].id
    }
    
    var cartIconName: String {
        return dependency.cartCoordinator.cartCount == 0 ? "cart_icon" : "cart\(dependency.cartCoordinator.cartCount)"
    }
    
    func userPressedAddToCart() {
        if let product = productData {
            dependency.cartCoordinator.addItemToCart(product, quantity: selectedQuantity)
        }
    }
}
