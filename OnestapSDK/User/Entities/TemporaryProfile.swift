//
//  TemporaryProfile.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class TemporaryProfile {
    public init() {}
    
    public var personalData: PersonalData? = nil
    public var vehicles: [Vehicle]? = nil
    public var addresses: [Address]? = nil
    public var phones: [Phone]? = nil
    public var documents: [Document]? = nil
    public var emails: [Email]? = nil
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
        
        var emailsJSON: [JSON]? = nil
        if let emails = self.emails {
            emailsJSON = []
            emails.forEach { emailsJSON?.append($0.toDictionary()) }
        }
        
        return [
            "applicationKey": OST.configuration.clientId,
            "data": [
                "personalData": personalData?.toDictionary() as Any,
                "vehicles": vehiclesJSON as Any,
                "addresses": addressesJSON as Any,
                "phones": phonesJSON as Any,
                "documents": documentsJSON as Any,
                "emails": emailsJSON as Any
            ]
        ]
    }
    
    func toJsonData() -> Data {
        return self.toDictionary().toJsonData()
    }
}
