//
//  APISessionConfiguration.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation

public enum NetworkProtocol: String {
    case http
    case https
}

public protocol APISessionConfigurationProtocol {
    var networkProtocol: NetworkProtocol { get } // Defaults to https
    var baseUrl: String { get }
}

extension APISessionConfigurationProtocol {
    var networkProtocol: NetworkProtocol {
        return .https
    }
}

class APISessionConfiguration: APISessionConfigurationProtocol {
    var baseUrl: String {
        return "b9757287.eu-gb.apigw.appdomain.cloud"
    }
}
