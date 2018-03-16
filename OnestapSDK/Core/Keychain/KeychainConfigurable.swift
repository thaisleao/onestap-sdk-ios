//
//  KeychainConfigurable.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 15/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

public protocol KeychainConfigurable {
    
    /// Name of your service
    var serviceName: String { get }
    
    /// The access group used to share keys with other apps from your organization
    var accessGroup: String? { get }
    
    /// The name of the data that'll be stored
    var dataName: String { get }
}
