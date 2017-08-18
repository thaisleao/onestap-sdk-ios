//
//  ApiReport.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 17/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

/// Returns in every response of the API
public struct ApiReport: InitializableWithData, InitializableWithJson {
    /// Field where the Report is about
    public private(set) var field: String
    
    /// Message explaining Field
    public private(set) var message: String
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        guard let field = json["field"] as? String,
            let message = json["message"] as? String
            else {
                throw NSError.createParseError()
        }
        
        self.field = field
        self.message = message
    }
}

extension ApiReport {
    var report: Report {
        return Report(field: field, message: message)
    }
}
