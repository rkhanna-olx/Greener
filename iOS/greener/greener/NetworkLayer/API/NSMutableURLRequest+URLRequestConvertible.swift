//
//  NSMutableURLRequest+URLRequestConvertible.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation
import Alamofire

extension NSMutableURLRequest: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        return self as URLRequest
    }
}

extension Request {
    func log() -> Self {
        
        #if DEBUG
        debugPrint(self)
        #endif
        
        return self
    }
}
