//
//  ApiClient.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T: InitializableWithData>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

extension URL {
    mutating func addParameter(_ value: String, forParameterName name: String) {
        var urlComponents: URLComponents! = URLComponents(url: self, resolvingAgainstBaseURL: false)
        var queryItems = urlComponents.queryItems ?? []
        
        queryItems.append(URLQueryItem(name: name, value: value))
        urlComponents.queryItems = queryItems
        
        self = urlComponents.url!
    }
    
    mutating func addParameters(_ parameters: [String: String]) {
        var urlComponents: URLComponents! = URLComponents(url: self, resolvingAgainstBaseURL: false)
        var queryItems = urlComponents.queryItems ?? []
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        
        urlComponents.queryItems = queryItems
        
        self = urlComponents.url!
    }
}

class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol
    
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    // This should be used mainly for testing purposes
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    // MARK: - ApiClient
    
    func execute<T: InitializableWithData>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            
            do {
                let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                completionHandler(
                    response.success ?
                        .success(response) :
                        .failure(ApiError(operationReport: response.operationReport))
                )
            } catch {
                completionHandler(.failure(error))
            }
        }
        dataTask.resume()
    }
}
