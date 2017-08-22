//
//  Phone.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Phone {
    public var phoneType: PhoneTypeEnum?
    public var fullNumber: String?
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
