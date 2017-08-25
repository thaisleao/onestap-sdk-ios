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
        return [
            "personalData": personalData?.toDictionary() as Any,
            "vehicles": vehicles?.flatMap { $0.toDictionary() } as Any,
            "addresses": addresses?.flatMap { $0.toDictionary() } as Any,
            "phones": phones?.flatMap { $0.toDictionary() } as Any,
            "documents": documents?.flatMap { $0.toDictionary() } as Any
        ]
    }
    
    func toJsonData() -> Data {
        return self.toDictionary().toJsonData()
    }
}
