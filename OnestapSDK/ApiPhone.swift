//
//  ApiPhone.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiPhone: InitializableWithData, InitializableWithJson {
    var key: String = ""
    var phoneType: PhoneTypeEnum
    var fullNumber: String
    
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
            let phoneTypeString = json["phoneType"] as? String,
            let phoneType = PhoneTypeEnum(rawValue: phoneTypeString),
            let fullNumber = json["fullNumber"] as? String else {
                throw NSError.createParseError()
        }
        
        self.key = key
        self.phoneType = phoneType
        self.fullNumber = fullNumber
    }
}

extension ApiPhone {
    var phone: Phone {
        var phone = Phone(phoneType: self.phoneType, fullNumber: self.fullNumber)
        phone.key = self.key
        return phone
    }
}
