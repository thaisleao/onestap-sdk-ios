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
        
        self.temporaryProfile()
    }
    
    func temporaryProfile() {
        let temporaryProfileApiRequest = TemporaryProfileApiRequest()
        
        apiClient.execute(request: temporaryProfileApiRequest) { (result: Result<ApiResponse<ApiTemporaryProfile>>) in
            switch result {
            case let .success(response):
                print(response)
                OST.configuration.temporaryProfileDataKey = response.entity.dataKey
//            case .failure(_): break
            case .failure(let error): print(error)
            }
        }
    }
}
