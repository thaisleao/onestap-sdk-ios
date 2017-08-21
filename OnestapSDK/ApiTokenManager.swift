//
//  ApiTokenManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class ApiTokenManager: TokenManager {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func refreshToken(completion: @escaping (Result<Token>) -> Void) {
        let tokenApiRequest = RefreshTokenApiRequest()
        
        apiClient.execute(request: tokenApiRequest) { (result: Result<ApiResponse<ApiToken>>) in
            switch result {
            case let .success(response):
                let token = response.entity.token
                UserDefaults.standard.accessToken = token.accessToken
                UserDefaults.standard.refreshToken = token.refreshToken
                completion(.success(token))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func accessToken(completion: @escaping (Result<Token>) -> Void) {
        let tokenApiRequest = AccessTokenApiRequest()
        
        apiClient.execute(request: tokenApiRequest) { (result: Result<ApiResponse<ApiToken>>) in
            switch result {
            case let .success(response):
                let token = response.entity.token
                UserDefaults.standard.accessToken = token.accessToken
                UserDefaults.standard.refreshToken = token.refreshToken
                UserDefaults.standard.userKey = token.userKey
                completion(.success(token))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func verifyToken(completion: @escaping (Result<Token>) -> Void) {
        let tokenApiRequest = VerifyTokenApiRequest()
        
        apiClient.execute(request: tokenApiRequest) { (result: Result<ApiResponse<ApiToken>>) in
            switch result {
            case let .success(response):
                let token = response.entity.token
                UserDefaults.standard.accessToken = token.accessToken
                completion(.success(token))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
