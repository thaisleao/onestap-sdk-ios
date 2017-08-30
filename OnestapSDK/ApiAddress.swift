//
//  ApiAddress.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiAddress: InitializableWithData, InitializableWithJson {
    var key: String = ""
    var street: String
    var number: String
    var complement: String? = nil
    var addressType: AddressTypeEnum? = nil
    var district: String? = nil
    var city: String
    var state: String
    var zipCode: String? = nil
    var addressReference: String? = nil
    var country: String? = nil
    
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
            let street = json["street"] as? String,
            let number = json["number"] as? String,
            let city = json["city"] as? String,
            let state = json["state"] as? String else {
                throw NSError.createParseError()
        }
        
        if let addressTypeString = json["addressType"] as? String {
            self.addressType = AddressTypeEnum(rawValue: addressTypeString)
        }
        
        self.key = key
        self.street = street
        self.city = city
        self.number = number
        self.state = state
        self.complement = json["complement"] as? String
        self.district = json["district"] as? String
        self.zipCode = json["zipCode"] as? String
        self.addressReference = json["addressReference"] as? String
        self.country = json["country"] as? String
    }
}

extension ApiAddress {
    var address: Address {
        var address = Address(street: self.street, number: self.number, city: self.city, state: self.state)
        address.addressReference = self.addressReference
        address.key = self.key
        address.addressType = self.addressType
        address.complement = self.complement
        address.district = self.district
        address.zipCode = self.zipCode
        address.country = self.country
        return address
    }
}
