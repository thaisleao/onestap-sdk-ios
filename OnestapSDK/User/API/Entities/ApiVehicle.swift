//
//  ApiVehicle.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 30/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiVehicle: InitializableWithData, InitializableWithJson {
    var key: String = ""
    var licensePlate: String
    var licensePlateCity: String? = nil
    var licensePlateState: String? = nil
    var licensePlateCountry: String? = nil
    
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
            let licensePlate = json["licensePlate"] as? String else {
                throw NSError.createParseError()
        }
        
        self.key = key
        self.licensePlate = licensePlate
        self.licensePlateCity = json["licensePlateCity"] as? String
        self.licensePlateState = json["licensePlateState"] as? String
        self.licensePlateCountry = json["licensePlateCountry"] as? String
    }
}

extension ApiVehicle {
    var vehicle: Vehicle {
        var vehicle = Vehicle(licensePlate: self.licensePlate)
        vehicle.key = self.key
        vehicle.licensePlateCountry = self.licensePlateCountry
        vehicle.licensePlateCity = self.licensePlateCity
        vehicle.licensePlateState = self.licensePlateState
        return vehicle
    }
}
