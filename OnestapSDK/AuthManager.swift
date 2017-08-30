//
//  TokenManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public protocol AuthManager {
    func refreshToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
    func accessToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
    func verifyToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
    func revokeToken(completion: @escaping (_ tokens: Result<GenericResponse>) -> Void)
    func handleRedirect(fromUrl url: URL, completion: @escaping (_ tokens: Result<Token>) -> Void)
    func loadAuthPage()
}

public class AuthManagerImplementation: AuthManager {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    /**
     Refreshes expired Token
     - parameters:
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func refreshToken(completion: @escaping (_ result: Result<Token>) -> Void) {
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
    
    /**
     Uses received token from redirect to get the remaining tokens
     - parameters:
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func accessToken(completion: @escaping (_ result: Result<Token>) -> Void) {
        let tokenApiRequest = AccessTokenApiRequest()
        
        apiClient.execute(request: tokenApiRequest) { (result: Result<ApiResponse<ApiToken>>) in
            switch result {
            case let .success(response):
                let token = response.entity.token
                UserDefaults.standard.accessToken = token.accessToken
                UserDefaults.standard.refreshToken = token.refreshToken
                UserDefaults.standard.userKey = token.userKey
                
                OST.shared.fingerPrint.sendFingerPrint()
                
                completion(.success(token))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    /**
     Handle when the login occurs with success on webpage and redirects back to the app
     - parameters:
        - fromUrl: Redirect `URL`
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func handleRedirect(fromUrl url: URL, completion: @escaping (_ result: Result<Token>) -> Void) {
        do {
            let redirectHandler = try RedirectHandlerImplementation(bundle: Bundle.main.infoDictionary)
            try redirectHandler.handleUri(open: url)
        } catch let error {
            completion(.failure(error))
        }
        
        accessToken { result in
            completion(result)
        }
    }
    
    /**
     Verify if the `accessToken` is expired
     - parameters:
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func verifyToken(completion: @escaping (_ result: Result<Token>) -> Void) {
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
    
    /**
     Revokes token so the will not be able to access user data until it logs in again
     - parameters:
        - completion: Callback
        - result: Response of type `Result<GenericResponse>`
    */
    public func revokeToken(completion: @escaping (_ result: Result<GenericResponse>) -> Void) {
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
    
    /// Opens Safari browser on one[S]tap login page
    public func loadAuthPage() {
        let url = RedirectHandlerImplementation.getLoginUrl(dataKey: OST.configuration.temporaryProfileDataKey)
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
