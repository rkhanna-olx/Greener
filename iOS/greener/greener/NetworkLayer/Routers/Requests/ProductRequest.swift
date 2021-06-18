//
//  ProductRequest.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import Alamofire

enum ProductRequest: RoutableRequestProtocol {
    
    private struct APIEndpoint {
        static let fetchProduct = "/getproductdetail/details"
        static let fetchEcoFriendlyItems = "/getecofriendly/items"
    }
    
    case fetchProduct(id: Int)
    case fetchEcoFriendlyItems
    
    var path: String {
        switch self {
        case .fetchProduct(_):
            return APIEndpoint.fetchProduct
        case .fetchEcoFriendlyItems:
            return APIEndpoint.fetchEcoFriendlyItems
        }
    }
    
    var parameters: [String : AnyObject]? {
        var parameters = [String: AnyObject]()
        switch self {
        case .fetchProduct(let id):
            parameters[APIParameterKeys.id] = id as AnyObject
        default:
            break;
        }
        return parameters
    }
    
//    var encoding: ParameterEncoding {
//        switch self {
//        case .fetchProduct(_):
//            return URLEncoding.default
//        default:
//            return JSONEncoding.default
//        }
//    }
}
