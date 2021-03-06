//
//  Vehicle.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Vehicle {
    public init(licensePlate: String) {
        self.licensePlate = licensePlate
    }
    public internal(set) var key: String = ""
    public var licensePlate: String
    public var licensePlateCity: String? = nil
    public var licensePlateState: String? = nil
    public var licensePlateCountry: String? = nil
}

extension Vehicle: Encondable {
    func toDictionary() -> JSON {
        return [
            "licensePlate": licensePlate,
            "licensePlateCity": licensePlateCity as Any,
            "licensePlateState": licensePlateState as Any,
            "licensePlateCountry": licensePlateCountry as Any
        ]
    }
}
