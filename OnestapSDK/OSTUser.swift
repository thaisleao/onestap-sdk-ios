//
//  OSTUser.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 30/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class OSTUser {
    public var user: UserManager!
    
    public init() {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.user = UserManagerImplementation(apiClient: apiClient)
    }
}
