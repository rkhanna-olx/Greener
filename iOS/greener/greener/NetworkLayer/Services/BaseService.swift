//
//  BaseService.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation

class BaseService {
    let apiManager: APIManagerProtocol
    let sessionConfiguration: APISessionConfigurationProtocol
    
    required init(apiManager: APIManagerProtocol, sessionConfiguration: APISessionConfigurationProtocol) {
        self.apiManager = apiManager
        self.sessionConfiguration = sessionConfiguration
    }
    
    func initializeRouter<T: RoutableRequestProtocol>(forRequest request: T) -> APIRouter {
        return APIRouter(serviceRequest: request, sessionConfiguration: sessionConfiguration)
    }
}
