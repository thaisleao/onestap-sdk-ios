//
//  OSTErrors.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public enum OSTErrors: Error {
    case plistNotFound
    case configNotFound
    case urlNameDifferentFromIdentifier
    case urlSchemeDoesNotExist
    case incorrectIdentifier
    case malformedUri
    case stateIsInvalid
    case invalidOperation
    case wrongParameters(message: String)
}
