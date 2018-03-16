//
//  Log.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 25/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Log {
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        return formatter
    }()
    
    private static var logDate: String {
        return dateFormatter.string(from: Date())
    }
    
    public static func apiData(request: URLRequest, response: Data?, urlResponse: HTTPURLResponse) {
        message("Start API Call - \(request.url?.absoluteString ?? "") - Status Code: \(urlResponse.statusCode)")
        if let headers = request.allHTTPHeaderFields {
            message("Request Headers")
            for header in headers {
                log(message: "    \(header.key): \(header.value)")
            }
        }
        if let requestData = request.httpBody {
            message("Request Payload")
            logJson(data: requestData)
        }
        if let response = response {
            message("Response Headers")
            for header in urlResponse.allHeaderFields {
                log(message: "    \(header.key): \(header.value)")
            }
            message("Response Payload")
            logJson(data: response)
        }
        message("End API Call\n")
    }
    
    public static func message(_ message: String?) {
        guard let message = message else { return }
        log(message: "[one[s]tap - \(logDate)] \(message)")
    }
    
    public static func message(_ error: Error) {
        message("An error occurred")
        log(message: error)
    }
}


// MARK: - Private methods
extension Log {
    private static func logJson(data: Data) {
        guard let jsonData = try? JSONSerialization.jsonObject(with: data),
            let prettyJSON = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted) else {
                return
        }
        let jsonString = String(data: prettyJSON, encoding: .utf8)
        log(message: jsonString ?? "")
    }
    
    private static func log(message: Any) {
        if OST.configuration.isLogEnabled {
            print(message)
        }
    }
}
