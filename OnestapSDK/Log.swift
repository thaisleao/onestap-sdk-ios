//
//  Log.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 25/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct Log {
    static func apiData(request: URLRequest, response: Data?, urlResponse: HTTPURLResponse) {
        log(message: "\n========== \(request.url?.absoluteString ?? "API CALL") ==========\n")
        if let requestData = request.httpBody {
            if let headers = request.allHTTPHeaderFields {
                log(message: "\n<-- REQUEST HEADERS ->\n")
                for header in headers {
                    log(message: "\(header.key): \(header.value)")
                }
            }
            
            log(message: "\n<-- REQUEST PAYLOAD ->\n")
            logJson(data: requestData)
        }
        if let response = response {
            log(message: "\n<-- RESPONSE HEADERS ->\n")
            for header in urlResponse.allHeaderFields {
                log(message: "\(header.key): \(header.value)")
            }
            log(message: "\n<-- RESPONSE PAYLOAD ->\n")
            logJson(data: response)
            log(message: "")
        }
        log(message: "\n========== END ==========\n")
    }
    
    private static func logJson(data: Data) {
        let json = String(data: data, encoding: .utf8)
        log(message: json)
    }
    
    private static func log(message: String?) {
        #if DEBUG
            if let message = message { print(message) }
        #endif
    }
}
