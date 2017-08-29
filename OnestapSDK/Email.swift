//
//  Email.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Email {
    public internal(set) var key: String = ""
    public var address: String
    public internal(set) var isValidated: Bool
    public internal(set) var isPrimary: Bool
}

extension Email: Encondable {
    func toDictionary() -> JSON {
        return [
            "address": address
        ]
    }
}
