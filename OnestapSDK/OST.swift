//
//  OST.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class OST {
    static var configuration: OSTConfiguration!
    
    public static var shared: OST!
    
    public required init(configuration: OSTConfiguration) {
        OST.configuration = configuration
        
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.auth = AuthManagerImplementation(apiClient: apiClient)
        self.user = UserManagerImplementation(apiClient: apiClient)
        
        OST.shared = self
    }
    
    public var auth: AuthManagerImplementation
    
    public var user: UserManagerImplementation
}
