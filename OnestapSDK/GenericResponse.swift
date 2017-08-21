//
//  GenericResponse.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct GenericResponse: Response {
    var success: Bool
    var operationReport: [ApiReport]
}
