//
//  UserManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public protocol UserManager {
    func temporaryProfile()
    func getUserData(including: [String]?, completion: @escaping (Result<Account>) -> Void)
}

public class UserManagerImplementation: UserManager {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    /// Sends `temporaryProfile` data so the user can register with some data already filled
    public func temporaryProfile() {
        guard OST.configuration.temporaryProfile != nil else {
            return
        }
        
        let temporaryProfileApiRequest = TemporaryProfileApiRequest()
        
        apiClient.execute(request: temporaryProfileApiRequest) { (result: Result<ApiResponse<ApiTemporaryProfile>>) in
            switch result {
            case let .success(response):
                OST.configuration.temporaryProfileDataKey = response.entity.dataKey
            case .failure(_): break
            }
        }
    }
    
    /**
     Receive User Data
     - parameters:
        - including: **Optional** parameter where you can pass what information you want to get
        - completion: Callback
        - result: Response of type `Result<Account>`
    */
    public func getUserData(including: [String]? = nil, completion: @escaping (_ result: Result<Account>) -> Void) {
        let including = including ?? []
        
        let getUserApiRequest = GetUserApiRequest(including: including)
        
        apiClient.execute(request: getUserApiRequest) { (result: Result<ApiResponse<ApiAccount>>) in
            switch result {
            case let .success(response):
                completion(.success(response.entity.account))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
