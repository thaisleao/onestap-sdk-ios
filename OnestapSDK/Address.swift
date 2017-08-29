//
//  Address.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Address {
    public init(street: String, number: String, city: String, state: String) {
        self.street = street
        self.number = number
        self.city = city
        self.state = state
    }
    public internal(set) var key: String = ""
    public var street: String
    public var number: String
    public var complement: String? = nil
    public var addressType: AddressTypeEnum? = nil
    public var district: String? = nil
    public var city: String
    public var state: String
    public var zipCode: String? = nil
    public var addressReference: String? = nil
    public var country: String? = nil
}

extension Address: Encondable {
    func toDictionary() -> JSON {
        return [
            "street": street,
            "number": number,
            "complement": complement as Any,
            "addressType": addressType?.rawValue as Any,
            "district": district as Any,
            "city": city,
            "state": state,
            "zipCode": zipCode as Any,
            "addressReference": addressReference as Any,
            "country": country as Any
        ]
    }
}

/// Possible Address Types for the API
public enum AddressTypeEnum: String {
    /// Home Address
    case home
    
    /// Work Address
    case work
    
    /// Billing Address
    case billing
    
    /// Shipping Address
    case shipping
}
