//
//  ApiAccount.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiAccount: InitializableWithData, InitializableWithJson {
    var accountKey: String = ""
    var isNewsLetterAllowed: Bool = false
    var publicProfile: ApiPublicProfile? = nil
    var personalData: ApiPersonalData? = nil
    var emails: [ApiEmail]? = nil
    var phones: [ApiPhone]? = nil
    var addresses: [ApiAddress]? = nil
    var documents: [ApiDocument]? = nil
    var vehicles: [ApiVehicle]? = nil
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        guard let json = json["account"] as? JSON else {
            return
        }
        
        guard let accountKey = json["accountKey"] as? String,
            let isNewsLetterAllowed = json["isNewsLetterAllowed"] as? Bool else {
            throw NSError.createParseError()
        }
        
        if let publicProfileJSON = json["publicProfile"] as? JSON {
            self.publicProfile = try ApiPublicProfile(json: publicProfileJSON)
        }
        
        if let personalDataJSON = json["personalData"] as? JSON {
            self.personalData = try ApiPersonalData(json: personalDataJSON)
        }
        
        if let emailsJSON = json["emails"] as? [JSON] {
            self.emails = try emailsJSON.flatMap { try ApiEmail(json: $0) }
        }
        
        if let phonesJSON = json["phone"] as? [JSON] {
            self.phones = try phonesJSON.flatMap { try ApiPhone(json: $0) }
        }
        
        if let addressesJSON = json["addresses"] as? [JSON] {
            self.addresses = try addressesJSON.flatMap { try ApiAddress(json: $0) }
        }
        
        if let documentsJSON = json["documents"] as? [JSON] {
            self.documents = try documentsJSON.flatMap { try ApiDocument(json: $0) }
        }
        
        if let vehiclesJSON = json["vehicles"] as? [JSON] {
            self.vehicles = try vehiclesJSON.flatMap { try ApiVehicle(json: $0) }
        }
        
        self.accountKey = accountKey
        self.isNewsLetterAllowed = isNewsLetterAllowed
    }
}

extension ApiAccount {
    var account: Account {
        return Account(accountKey: self.accountKey,
                       isNewsLetterEnabled: self.isNewsLetterAllowed,
                       publicProfile: self.publicProfile?.publicProfile,
                       personalData: self.personalData?.personalData,
                       emails: self.emails?.flatMap { $0.email },
                       phones: self.phones?.flatMap { $0.phone },
                       addresses: self.addresses?.flatMap { $0.address },
                       documents: self.documents?.flatMap { $0.document },
                       vehicles: self.vehicles?.flatMap { $0.vehicle })
    }
}
