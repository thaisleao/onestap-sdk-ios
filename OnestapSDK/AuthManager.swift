//
//  TokenManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

protocol AuthManager {
    func refreshToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
    func accessToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
    func verifyToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
    func revokeToken(completion: @escaping (_ tokens: Result<GenericResponse>) -> Void)
    func handleRedirect(fromUrl url: URL, completion: @escaping (_ tokens: Result<Token>) -> Void)
}

public class AuthManagerImplementation: AuthManager {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    public func refreshToken(completion: @escaping (Result<Token>) -> Void) {
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
    
    public func handleRedirect(fromUrl url: URL, completion: @escaping (Result<Token>) -> Void) {
        accessToken { result in
            completion(result)
        }
    }
    
    public func verifyToken(completion: @escaping (Result<Token>) -> Void) {
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
    
    public func revokeToken(completion: @escaping (Result<GenericResponse>) -> Void) {
        let tokenApiRequest = RevokeTokenApiRequest()
        
        apiClient.execute(request: tokenApiRequest) { (result: Result<ApiResponse<ApiToken>>) in
            UserDefaults.standard.accessToken = nil
            UserDefaults.standard.refreshToken = nil
            UserDefaults.standard.userKey = nil
            
            switch result {
            case let .success(response):
                let genericResponse = GenericResponse(success: response.success, operationReport: response.operationReport)
                completion(.success(genericResponse))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
