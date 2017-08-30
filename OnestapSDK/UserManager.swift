//
//  UserManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

protocol UserManager {
    func temporaryProfile()
}

public class UserManagerImplementation: UserManager {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func temporaryProfile() {
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
    
    public func getUserData(includePersonalData: Bool = false,
        includeEmails: Bool = false,
        includePhones: Bool = false,
        includeAddresses: Bool = false,
        includeDocuments: Bool = false,
        completion: @escaping (Result<Account>) -> Void) {
        
        let getUserApiRequest = GetUserApiRequest(includePersonalData: includePersonalData,
                                                  includeEmails: includeEmails,
                                                  includePhones: includePhones,
                                                  includeAddresses: includeAddresses,
                                                  includeDocuments: includeDocuments)
        
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
