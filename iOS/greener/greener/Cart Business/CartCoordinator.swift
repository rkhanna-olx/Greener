//
//  CartCoordinator.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import Foundation

protocol CartItemDTOProtocol {
    var product: ProductDTOProtocol { get }
    var quantity: Int { get set }
    var cost: Int { get }
}

class CartItemDTO: CartItemDTOProtocol {
    var product: ProductDTOProtocol
    var quantity: Int
    
    var cost: Int {
        get {
            return product.price * quantity
        }
    }
    
    init(product: ProductDTOProtocol, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}

protocol CartCoodinatorProtocol {
    var cartTotalCost: Int { get }
    func addItemToCart(_ product: ProductDTOProtocol, quantity: Int)
    func removeItemFromCart(_ productId: Int)
    var cartCount: Int { get }
    func getCartItem(at index: Int) -> CartItemDTOProtocol?
}

class CartCoodinator: CartCoodinatorProtocol {
    static let sharedInstance = CartCoodinator()
    private var cartItems: [CartItemDTOProtocol] = []
    
    var cartTotalCost: Int { return cartItems.map({$0.cost}).reduce(0, +) }
    var cartCount: Int { return cartItems.count }
    
    func addItemToCart(_ product: ProductDTOProtocol, quantity: Int) {
        if let index = cartItems.firstIndex(where: {$0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append(CartItemDTO(product: product, quantity: quantity))
        }
    }
    
    func removeItemFromCart(_ productId: Int) {
        cartItems.removeAll(where: {$0.product.id == productId })
    }
    
    func getCartItem(at index: Int) -> CartItemDTOProtocol? {
        guard index < cartCount else { return nil }
        return cartItems[index]
    }
}
