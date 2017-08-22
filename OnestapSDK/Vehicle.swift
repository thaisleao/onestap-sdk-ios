//
//  Vehicle.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Vehicle {
    public var licensePlate: String?
    public var licensePlateCity: String?
    public var licensePlateState: String?
    public var licensePlateCountry: String?
}

extension Vehicle: Encondable {
    func toDictionary() -> JSON {
        return [
            "licensePlate": licensePlate as Any,
            "licensePlateCity": licensePlateCity as Any,
            "licensePlateState": licensePlateState as Any,
            "licensePlateCountry": licensePlateCountry as Any
        ]
    }
}
