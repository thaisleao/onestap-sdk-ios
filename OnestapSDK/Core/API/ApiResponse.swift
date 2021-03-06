//
//  ApiResponse.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 17/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

// All API responses have those properties
protocol Response {
    var success: Bool { get set }
    var operationReport: [ApiReport] { get set }
}

// Custom initialization to Response properties
extension Response {
    mutating func initializeResponse(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        
        try self.initializeResponse(json: json)
    }
    
    mutating func initializeResponse(json: JSON) throws {
        self.operationReport = []
        guard let success = json["success"] as? Bool else {
            self.success = false
            return
        }
        
        self.success = success
        
        guard let operationReportJSON = json["operationReport"] as? [JSON] else {
            return
        }
        
        let operationReport = try operationReportJSON.compactMap({ operationReport in
            return try ApiReport(json: operationReport)
        })
        
        self.operationReport = operationReport
    }
}


// All entities that model the API responses can implement this so we can handle all responses in a generic way
protocol InitializableWithData {
    init(data: Data?) throws
}

// Optionally, if you use JSON you can implement InitializableWithJson protocol
protocol InitializableWithJson {
    init(json: JSON) throws
}

// Can be thrown when we can't even reach the API
struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

// Can be thrown when we reach the API but the it returns a 5xx
struct ApiGeneralError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

// Can be thrown when we reach the API but the it returns a 4xx
struct ApiError: Error {
    var operationReport: [ApiReport]
}

// Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

// This wraps a successful API response and it includes the generic data as well
// The reason why we need this wrapper is that we want to pass to the client the status code and the raw response as well
struct ApiResponse<T: InitializableWithData>: Response {
    var success: Bool = false
    var operationReport: [ApiReport] = []

    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try T(data: data)
            self.httpUrlResponse = httpUrlResponse
            self.data = data
            try initializeResponse(data: data)
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}

// Some endpoints might return a 204 No Content
// We can't have Void implement InitializableWithData so we've created a "Void" response
struct VoidResponse: InitializableWithData {
    init(data: Data?) throws {}
}

extension Array: InitializableWithData {
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let jsonArray = jsonObject as? [JSON] else {
                throw NSError.createParseError()
        }
        
        guard let element = Element.self as? InitializableWithJson.Type else {
            throw NSError.createParseError()
        }
        
        self = try jsonArray.map( { return try element.init(json: $0) as! Element } )
    }
}

extension NSError {
    static func createParseError() -> NSError {
        return NSError(domain: "com.onestap.OnestapSDK",
                       code: ApiParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
