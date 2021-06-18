//
//  APIManager.swift
//  VaccineTracker
//
//  Created by Rahul on 04/05/21.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func doRequest(_ request: URLRequestConvertible, completionHandler: @escaping (_ request: URLRequest?, _ response: Data?, _ error: Error?) -> Void)
    func doRequest<T: Codable>(_ request: URLRequestConvertible, completionHandler: @escaping (_ request: URLRequest?, _ response: T?, _ error: Error?) -> Void)
}

class APIManager {
    fileprivate var sessionManager: SessionManager!
    fileprivate let queue: DispatchQueue = DispatchQueue(label: "com.VaccineTracker")
    
    init() {
        initSessionManager()
    }
    
    func initSessionManager() {
        let configuration = URLSessionConfiguration.default
        sessionManager = SessionManager(configuration: configuration)
    }
}

extension APIManager: APIManagerProtocol {
    func doRequest(_ request: URLRequestConvertible, completionHandler: @escaping (_ request: URLRequest?, _ response: Data?, _ error: Error?) -> Void) {
        sessionManager.request(request).log().validate().responseJSON(queue: queue) { (response) in
            let request = response.request
            var requestError: Error? = nil
            switch response.result {
            case .success:
                break
            case .failure(let error):
                requestError = error
            }
            DispatchQueue.main.async {
                completionHandler(request, response.data, requestError)
            }
        }
    }
    
    func doRequest<T: Codable>(_ request: URLRequestConvertible, completionHandler: @escaping (_ request: URLRequest?, _ response: T?, _ error: Error?) -> Void) {
        sessionManager.request(request).log().validate().responseJSON(queue: queue) { (response) in
            let request = response.request
            var responseObject: T? = nil
            var requestError: Error? = nil
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let bodyValue = json["body"] {
                            let bodyData = try JSONSerialization.data(withJSONObject: bodyValue, options: [])
                            let mappedResponse = try JSONDecoder().decode(T.self, from: bodyData)
                            responseObject = mappedResponse
                        }
                    } catch let error {
                        print("Error: \(error)")
                    }
                }
            case .failure(let error):
                requestError = error
            }
            DispatchQueue.main.async {
                completionHandler(request, responseObject, requestError)
            }
        }
    }
}

