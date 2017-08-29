//
//  ApiAccount.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiAccount: InitializableWithData, InitializableWithJson {
    var accountKey: String
    var isNewsLetterEnabled: Bool
    var publicProfile: ApiPublicProfile? = nil
    var personalData: ApiPersonalData? = nil
    var emails: [ApiEmail]? = nil
    var phones: [ApiPhone]? = nil
    var addresses: [ApiAddress]? = nil
    var documents: [ApiDocument]? = nil
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        guard let json = json["account"] as? JSON,
            let accountKey = json["accountKey"] as? String,
            let isNewsLetterEnabled = json["isNewsLetterEnabled"] as? Bool else {
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
        
        self.accountKey = accountKey
        self.isNewsLetterEnabled = isNewsLetterEnabled
    }
}
