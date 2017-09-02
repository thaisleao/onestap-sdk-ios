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
    
    func getUser(categories: [OSTCategoriesEnum]?, completion: @escaping (Result<Account>) -> Void)
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
    
    func getUser(categories: [OSTCategoriesEnum]? = nil, completion: @escaping (_ result: Result<Account>) -> Void) {
        let including = categories ?? []
        
        let getUserApiRequest = GetUserApiRequest(categories: including)
        
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
