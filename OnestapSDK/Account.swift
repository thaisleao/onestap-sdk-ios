//
//  Account.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Account {
    public var accountKey: String
    public var isNewsLetterEnabled: Bool
    public var publicProfile: PublicProfile?
    public var personalData: PersonalData?
    public var emails: [Email]?
    public var phones: [Phone]?
    public var addresses: [Address]?
    public var documents: [Document]?
}
