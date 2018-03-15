//
//  KeychainConfiguration.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 15/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

struct KeychainConfiguration: KeychainConfigurable {
    var serviceName = "OnestapMobileSDK"
    
    var accessGroup: String? = nil
    
    var dataName: String
    
    init(dataName: String) {
        self.dataName = dataName
    }
}
