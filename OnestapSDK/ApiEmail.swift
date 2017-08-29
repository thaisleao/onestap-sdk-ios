//
//  ApiEmail.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiEmail: InitializableWithData, InitializableWithJson {
    var key: String = ""
    var address: String = ""
    var isValidated: Bool = false
    var isPrimary: Bool = false
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        guard let key = json["key"] as? String,
            let address = json["address"] as? String,
            let isValidated = json["isValidated"] as? Bool,
            let isPrimary = json["isPrimary"] as? Bool else {
            throw NSError.createParseError()
        }
        
        self.key = key
        self.address = address
        self.isValidated = isValidated
        self.isPrimary = isPrimary
    }
}
