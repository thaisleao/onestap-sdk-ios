//
//  OSTConfiguration.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

/// Configuration necessary to initialize the SDK
public struct OSTConfiguration {
    /// Your Client ID
    public let clientId: String
    
    /// Your Client Secret
    public let clientSecret: String
    
    /// Your app host registered on URL Types (e. g.: **somehost**://somescheme), where host is everything before `://`.
    public let host: String
    
    /// Your app scheme (e. g.: somehost://**somescheme**), where host is everything after `://`. You can use anything on scheme.
    public let scheme: String
    
    /// Your Finger Print ID if you want to send data to our anti-fraud.
    public let fingerPrintId: String?
    
    /// The environment you want to use our SDK, the options are `sandbox` and `production` environments. The default value is **sandbox**
    public let environment: OSTEnvironmentEnum
}
