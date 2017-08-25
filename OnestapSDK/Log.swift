//
//  Log.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 25/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct Log {
    static func apiData(request: Data?, response: Data?, url: URL?) {
        log(message: "\n========== \(url?.absoluteString ?? "API CALL") ==========\n")
        if let request = request {
            log(message: "\n<-- REQUEST PAYLOAD ->\n")
            logJson(data: request)
        }
        if let response = response {
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
