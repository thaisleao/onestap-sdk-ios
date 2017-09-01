//
//  OSTAuth.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 30/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

/// Class containing all authorization implementations
public class OSTAuth {
    /// Implements `AuthManager`
    private var authManager: AuthManager
    
    public init() {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.authManager = AuthManagerImplementation(apiClient: apiClient)
    }
    
    /**
     Refreshes expired Token
     - parameters:
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func refreshToken(completion: @escaping (_ result: Result<Token>) -> Void) { self.authManager.refreshToken { completion($0) } }
    
    /**
     Uses received token from redirect to get the remaining tokens
     - parameters:
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    func accessToken(completion: @escaping (_ result: Result<Token>) -> Void) { self.authManager.accessToken { completion($0) } }
    
    /**
     Handle when the login occurs with success on webpage and redirects back to the app
     - parameters:
        - fromUrl: Redirect `URL`
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func handleRedirect(fromUrl url: URL, completion: @escaping (_ result: Result<Token>) -> Void) { self.authManager.handleRedirect(fromUrl: url) { completion($0) } }
    
    /**
     Verify if the `accessToken` is expired
     - parameters:
        - completion: Callback
        - result: Response of type `Result<Token>`
     */
    public func verifyToken(completion: @escaping (_ result: Result<Token>) -> Void) { self.authManager.verifyToken { completion($0) } }
    
    /**
     Revokes token so the will not be able to access user data until it logs in again
     - parameters:
        - completion: Callback
        - result: Response of type `Result<GenericResponse>`
     */
    public func revokeToken(completion: @escaping (_ result: Result<GenericResponse>) -> Void) { self.authManager.revokeToken { completion($0) } }
    
    /// Opens Safari browser on one[S]tap login page
    public func loadAuthPage(viewController: UIViewController? = nil) { self.authManager.loadAuthPage(viewController: viewController) }
}
