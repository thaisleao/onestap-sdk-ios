//
//  TemporaryProfile.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct TemporaryProfile {
    public init() {}
    
    public var personalData: PersonalData? = nil
    public var vehicles: [Vehicle]? = nil
    public var addresses: [Address]? = nil
    public var phones: [Phone]? = nil
    public var documents: [Document]? = nil
}

extension TemporaryProfile: Encondable {
    func toDictionary() -> JSON {
        var vehiclesJSON: [JSON]? = nil
        if let vehicles = self.vehicles {
            vehiclesJSON = []
            vehicles.forEach { vehicle in
                vehiclesJSON!.append(vehicle.toDictionary())
            }
        }
        
        var addressesJSON: [JSON]? = nil
        if let addresses = self.addresses {
            addressesJSON = []
            addresses.forEach { address in
                addressesJSON!.append(address.toDictionary())
            }
        }
        
        var phonesJSON: [JSON]? = nil
        if let phones = self.phones {
            phonesJSON = []
            phones.forEach { phone in
                phonesJSON!.append(phone.toDictionary())
            }
        }
        
        var documentsJSON: [JSON]? = nil
        if let documents = self.documents {
            documentsJSON = []
            documents.forEach { document in
                documentsJSON!.append(document.toDictionary())
            }
        }
        
        return [
            "personalData": personalData?.toDictionary() as Any,
            "vehicles": vehiclesJSON as Any,
            "addresses": addressesJSON as Any,
            "phones": phonesJSON as Any,
            "documents": documentsJSON as Any
        ]
    }
    
    func toJsonData() -> Data {
        return self.toDictionary().toJsonData()
    }
}
