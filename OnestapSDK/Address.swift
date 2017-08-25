//
//  Address.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Address {
    public init() {}
    public var street: String?
    public var number: String?
    public var complement: String?
    public var addressType: AddressTypeEnum?
    public var district: String?
    public var city: String?
    public var state: String?
    public var zipCode: String?
    public var addressReference: String?
    public var country: String?
}

extension Address: Encondable {
    func toDictionary() -> JSON {
        return [
            "street": street as Any,
            "number": number as Any,
            "complement": complement as Any,
            "addressType": addressType?.rawValue as Any,
            "district": district as Any,
            "city": city as Any,
            "state": state as Any,
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
