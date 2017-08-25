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
        log(message: "========== \(url?.absoluteString ?? "API CALL") ==========")
        log(message: "")
        if let request = request {
            log(message: "<-- REQUEST PAYLOAD ->")
            logJson(data: request)
            log(message: "")
        }
        if let response = response {
            log(message: "<-- RESPONSE PAYLOAD ->")
            logJson(data: response)
            log(message: "")
        }
        log(message: "========== END ==========")
        log(message: "")
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
