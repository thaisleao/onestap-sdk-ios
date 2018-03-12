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
    
    /**
     All your configuration before start using the SDK should be in here.
     
     - parameters:
        - environment: If nothing is passed the default value is **.sandbox**
        - clientId: Your Client ID
        - clientSecret: Your Client Secret
        - host: The `host` registered on URL Types of the application
        - scheme: The desired `scheme` to appear on redirect URL
        - fingerPrintId: The ID given by **RexLab** to make anti-fraud security. Default value is `nil`
        - temporaryProfile: Used to make easier registration of your user. Default value is `nil`
    */
    public init(environment: OSTEnvironmentEnum = .sandbox,
                         clientId: String,
                         clientSecret: String,
                         scheme: String, host: String,
                         fingerPrintId: String? = nil,
                         temporaryProfile: TemporaryProfile? = nil,
                         primaryColor: UIColor? = nil,
                         secondaryColor: UIColor? = nil) {
        self.environment = environment
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scheme = scheme
        self.host = host
        self.fingerPrintId = fingerPrintId
        self.temporaryProfile = temporaryProfile
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    /// Your Client ID
    public let clientId: String
    
    /// Your Client Secret
    public let clientSecret: String
    
    /// Encoded Client ID and Secret
    internal var encodedClient: String {
        let clientIdSecret = "\(self.clientId):\(self.clientSecret)"
        return clientIdSecret.toBase64()
    }
    
    /// Your app host registered on URL Types (e.g.: **somescheme**://somehost), where scheme is everything before `://`.
    public let scheme: String
    
    /// Your app scheme (e. g.: somescheme://**somehost**), where host is everything after `://`. You can use anything on host.
    public let host: String
    
    /// Redirect Uri created from `scheme` + `host` combination (e.g.: `scheme://host`)
    internal var redirectUri: String {
        get {
            return "\(scheme)://\(host)"
        }
    }
    
    /// The primary color of your app
    public let primaryColor: UIColor?
    
    /// The secondary color of your app
    public let secondaryColor: UIColor?
    
    /// Your Finger Print ID if you want to send data to our anti-fraud.
    public let fingerPrintId: String?
    
    /// The environment you want to use our SDK, the options are `sandbox` and `production` environments. The default value is **sandbox**
    public let environment: OSTEnvironmentEnum
    
    /// When `temporaryProfile` is not nil it'll complete registration steps for the user
    public let temporaryProfile: TemporaryProfile?
    
    /// If temporaryProfile is set, the DataKey should be filled
    internal var temporaryProfileDataKey: String? = nil
}
