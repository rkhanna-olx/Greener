//
//  BaseRouterProtocol.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation
import Alamofire

protocol RoutableRequestProtocol {
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    
    var path: String { get }
    var parameters: [String: AnyObject]? { get }
    var baseUrl: String? { get }
}

extension RoutableRequestProtocol {
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }

    var baseUrl: String? {
        return nil
    }
    
}
