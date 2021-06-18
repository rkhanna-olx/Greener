//
//  API.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation

internal class API {
    private static var apiManager: APIManagerProtocol = APIManager()
    fileprivate static var sessionConfiguration: APISessionConfigurationProtocol!
    
    static func initialize(withConfiguration configuration: APISessionConfigurationProtocol) {
        self.sessionConfiguration = configuration
    }
}

extension API {
    private static func initializeService<T>(of typeClass: T.Type) -> T where T: BaseService {
        return T(apiManager: apiManager, sessionConfiguration: sessionConfiguration)
    }
    
    static func productService() -> ProductServiceProtocol {
        return initializeService(of: ProductService.self)
    }
}
