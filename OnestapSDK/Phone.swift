//
//  Phone.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Phone {
    public private(set) var phoneType: PhoneTypeEnum?
    public private(set) var fullNumber: String?
    public private(set) var isValidated: Bool?
    public private(set) var isPrimary: Bool?
}

/// Possible Phone Types for the API
public enum PhoneTypeEnum: String {
    /// Home Phone
    case home
    
    /// Mobile Phone
    case mobile
    
    /// Work Phone
    case work
}
