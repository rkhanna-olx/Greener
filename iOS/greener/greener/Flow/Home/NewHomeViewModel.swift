//
//  NewHomeViewModel.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import Foundation
import MVVMRB

protocol NewHomeViewModelDependencyProtocol {
    var productService: ProductServiceProtocol { get }
}

protocol NewHomeViewModelProtocol {
    func fetchEcofriendlyItem(_ completion: @escaping (Bool) -> Void)
    
    var ecofriendlyItems: [SimilarDTOProtocol] { get }
    var hotDealsData: [HotDealsTableViewCellDataModel] { get }
    var productCategoriesData: [HotDealsTableViewCellDataModel] { get }
    
    func getProductIdForEcofriendlyItem(at index: Int) -> Int?
}

class NewHomeViewModel: ViewModel<NewHomeViewModelDependencyProtocol>, NewHomeViewModelProtocol {
    var ecofriendlyItems: [SimilarDTOProtocol] = [SimilarDTO(id: 1, productImageUrl: "item_detail", title: "Sample title 1", price: 25, ecoRating: 1),
                                                   SimilarDTO(id: 2, productImageUrl: "item_detail", title: "Sample title 2", price: 25, ecoRating: 2),
                                                   SimilarDTO(id: 3, productImageUrl: "item_detail", title: "Sample title 3", price: 25, ecoRating: 3),
                                                   SimilarDTO(id: 4, productImageUrl: "item_detail", title: "Sample title 4", price: 25, ecoRating: 1),
                                                   SimilarDTO(id: 5, productImageUrl: "item_detail", title: "Sample title 5", price: 25, ecoRating: 2)]
    var hotDealsData: [HotDealsTableViewCellDataModel] =  [HotDealsTableViewCellDataModel(image: "deal1", text: nil),
                                                           HotDealsTableViewCellDataModel(image: "deal2", text: nil)]
    var productCategoriesData: [HotDealsTableViewCellDataModel] = [HotDealsTableViewCellDataModel(image: "food_packaging", text: "Food packaging"),
                                                                   HotDealsTableViewCellDataModel(image: "cardboard", text: "Cardboard"),
                                                                   HotDealsTableViewCellDataModel(image: "foil", text: "Foil"),
                                                                   HotDealsTableViewCellDataModel(image: "straws", text: "Straws"),
                                                                   HotDealsTableViewCellDataModel(image: "pet_bottles", text: "Pet bottles")]
    
    func fetchEcofriendlyItem(_ completion: @escaping (Bool) -> Void) {
        dependency.productService.fetchEcoFriendlyItems { [weak self] data, error in
            if let data = data {
                self?.ecofriendlyItems = data
            }
            completion(error == nil)
        }
    }
    
    func getProductIdForEcofriendlyItem(at index: Int) -> Int? {
        guard index < ecofriendlyItems.count else { return nil }
        return ecofriendlyItems[index].id
    }
}
