//
//  Address.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Address {
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
