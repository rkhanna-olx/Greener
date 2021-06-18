//
//  ProductService.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProductDetail(_ id: Int, completion: @escaping (ProductDTOProtocol?, Error?) -> Void)
    func fetchEcoFriendlyItems(completion: @escaping ([SimilarDTOProtocol]?, Error?) -> Void)
}

class ProductService: BaseService, ProductServiceProtocol {
    func fetchProductDetail(_ id: Int, completion: @escaping (ProductDTOProtocol?, Error?) -> Void) {
        let request = ProductRequest.fetchProduct(id: id)
        
        let router = initializeRouter(forRequest: request)
        
        apiManager.doRequest(router) { (request, response: ProductDTO?, error) in
            completion(response, error)
        }
    }
    
    func fetchEcoFriendlyItems(completion: @escaping ([SimilarDTOProtocol]?, Error?) -> Void) {
        let request = ProductRequest.fetchEcoFriendlyItems
        let router = initializeRouter(forRequest: request)
        
        apiManager.doRequest(router) { (request, response: [SimilarDTO]?, error) in
            completion(response, error)
        }
    }
}
