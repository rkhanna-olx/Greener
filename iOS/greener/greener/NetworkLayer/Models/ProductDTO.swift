//
//  ProductDTO.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation

protocol ProductDTOProtocol: Codable {
    var id: Int { get }
    var sellerName: String { get }
    var title: String { get }
    var productImageUrl: String? { get }
    var price: Int { get }
    var minQuantity: Int { get }
    var rating: Float { get }
    var ratingCount: Int { get }
    var productDetail: String { get }
    var aboutSeller: String { get }
    var sellerContact: String? { get }
    var trustedBy: [String]? { get }
    var similar: [SimilarDTOProtocol]? { get }
    var ecoRating: Int { get }
    var isRecommended: Bool { get }
}

protocol SimilarDTOProtocol: Codable {
    var id: Int { get }
    var productImageUrl: String? { get }
    var title: String { get }
    var price: Int { get }
    var ecoRating: Int { get}
}


struct ProductDTO: ProductDTOProtocol {
    var id: Int
    var sellerName: String
    var title: String
    var productImageUrl: String?
    var price: Int
    var minQuantity: Int
    var rating: Float
    var ratingCount: Int
    var productDetail: String
    var aboutSeller: String
    var sellerContact: String?
    var trustedBy: [String]?
    var similar: [SimilarDTOProtocol]? {
        get { return _similar }
    }
    var _similar: [SimilarDTO]?
    var ecoRating: Int
    var isRecommended: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case sellerName
        case title
        case productImageUrl = "imageUrl"
        case price
        case minQuantity = "quantity"
        case rating
        case ratingCount
        case productDetail
        case aboutSeller
        case sellerContact
        case trustedBy = "trusted_by"
        case _similar = "similar"
        case ecoRating
        case isRecommended
    }
    
}

struct SimilarDTO: SimilarDTOProtocol {
    var id: Int
    var productImageUrl: String?
    var title: String
    var price: Int
    var ecoRating: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case productImageUrl = "imageUrl"
        case title
        case price
        case ecoRating
    }
}
