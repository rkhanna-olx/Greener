//
//  APIRouter.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation
import Alamofire

class APIRouter: URLRequestConvertible {
    let sessionConfiguration: APISessionConfigurationProtocol
    let serviceRequest: RoutableRequestProtocol
    
    init(serviceRequest: RoutableRequestProtocol, sessionConfiguration: APISessionConfigurationProtocol) {
        self.sessionConfiguration = sessionConfiguration
        self.serviceRequest = serviceRequest
    }
    
    func asURLRequest() -> URLRequest {
        let mutableURLRequest = NSMutableURLRequest()
        
        var baseUrl = sessionConfiguration.baseUrl
        if let serviceBaseUrl = serviceRequest.baseUrl {
            baseUrl = serviceBaseUrl
        }
        let baseUrlString = "\(sessionConfiguration.networkProtocol.rawValue)://" + "\(baseUrl)"
        
        if let baseURL = URL(string: baseUrlString),
            let requestURL = URL(string: serviceRequest.path),
            let components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false) {
            mutableURLRequest.url = components.url(relativeTo: baseURL)
        } else {
            mutableURLRequest.url = URL(string: baseUrlString)
        }
        
        mutableURLRequest.httpMethod = serviceRequest.method.rawValue
        mutableURLRequest.cachePolicy = .reloadIgnoringCacheData
        
        if let encodedRequest = try? serviceRequest.encoding.encode(mutableURLRequest, with: serviceRequest.parameters) {
            return encodedRequest
        } else {
            return mutableURLRequest as URLRequest
        }
    }
}
