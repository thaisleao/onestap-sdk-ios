//
//  ApiReport.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 17/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

/// Returns in every response of the API
public struct ApiReport {
    /// Field where the Report is about
    public private(set) var field: String
    
    /// Message explaining Field
    public private(set) var message: String
    
    init?(json: JSON) {
        guard let field = json["field"] as? String,
            let message = json["message"] as? String
            else {
                return nil
        }
        
        self.field = field
        self.message = message
    }
}
