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
    private var userManager: UserManager!
    
    public init() {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.userManager = UserManagerImplementation(apiClient: apiClient)
    }
    
    /// Sends `temporaryProfile` data so the user can register with some data already filled
    func temporaryProfile() {
        userManager.temporaryProfile()
    }
    
    /**
     Receive User Data
     - parameters:
        - categories: **Optional** parameter where you can pass what information you want to get
        - completion: Callback
        - result: Response of type `Result<Account>`
     */
    public func getUser(categories: [OSTCategoriesEnum]? = nil, completion: @escaping (_ result: Result<Account>) -> Void) {
        self.userManager.getUser(categories: categories) { completion($0) }
    }
}
