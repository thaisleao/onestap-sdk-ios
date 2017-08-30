//
//  OSTAuth.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 30/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

/// Class containing all authorization implementations
public class OSTAuth {
    /// Implements `AuthManager`
    public var auth: AuthManager
    
    /**
     Initialize OSTAuth
     - parameters:
        - authManager: Only present for injection purposes
    */
    public init(authManager: AuthManager? = nil) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.auth = authManager ?? AuthManagerImplementation(apiClient: apiClient)
    }
}
