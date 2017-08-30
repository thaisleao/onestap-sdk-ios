//
//  OSTUser.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 30/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class OSTUser {
    /// Implements `UserManager`
    public var user: UserManager!
    
    /**
     Initialize OSTUser
     - parameters:
        - userManager: Only present for injection purposes
     */
    public init(userManager: UserManager? = nil) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.user = userManager ?? UserManagerImplementation(apiClient: apiClient)
    }
}
