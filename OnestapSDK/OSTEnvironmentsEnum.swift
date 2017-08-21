//
//  OSTEnvironmentsEnum.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public enum OSTEnvironmentEnum: String {
    /// Sandbox Environment
    case sandbox
    
    /// Production Environment
    case production
    
    /**
     Create `FCEnvironmentEnum` by passing a `String`.
     Default value is `.sandbox`.
     
     - parameters:
     - rawValue: String that contains corresponding value to the enumerator
     */
    public init(rawValue: String) {
        ApiUrls.isStaging = false
        switch rawValue.lowercased() {
        case "production":
            self = .production
        case "sandbox":
            self = .sandbox
        case "staging":
            ApiUrls.isStaging = true
            self = .sandbox
        default:
            self = .sandbox
        }
    }
    
    /**
     Return Web URL to open login page
     */
    internal var webURL: URL {
        get {
            if ApiUrls.isStaging { return ApiUrls.connectStagingWebUrl }
            switch self {
            case .production:
                return ApiUrls.connectProductionWebUrl
            case .sandbox:
                return ApiUrls.connectSandboxWebUrl
            }
        }
    }
    
    /**
     Return API URL to communicate with the Authentication API
     */
    internal var apiURL: URL {
        get {
            if ApiUrls.isStaging { return ApiUrls.connectStagingApiUrl }
            switch self {
            case .production:
                return ApiUrls.connectProductionApiUrl
            case .sandbox:
                return ApiUrls.connectSandboxApiUrl
            }
        }
    }
    
    /**
     Return API URL to communicate with the Management API
     */
    internal var userManagementURL: URL {
        get {
            if ApiUrls.isStaging { return ApiUrls.connectStagingUserManagementUrl }
            switch self {
            case .production:
                return ApiUrls.connectProductionUserManagementUrl
            case .sandbox:
                return ApiUrls.connectSandboxUserManagementUrl
            }
        }
    }
    
    private struct ApiUrls {
        static var isStaging: Bool = false
        
        static let connectStagingWebUrl: URL! = URL(string: "http://flipconnect-signin-develop.herokuapp.com/")
        static let connectStagingApiUrl: URL! = URL(string: "http://dlp-qrservices.cloudapp.net:20112/api/")
        static let connectStagingUserManagementUrl: URL! = URL(string: "http://dlp-qrservices.cloudapp.net:20115/")
        
        static let connectSandboxWebUrl: URL! = URL(string: "https://signin-sandbox.flipconnect.io/")
        static let connectSandboxApiUrl: URL! = URL(string: "https://auth-sandbox.flipconnect.io/api/")
        static let connectSandboxUserManagementUrl: URL! = URL(string: "https://api-sandbox.flipconnect.io/")
        
        static let connectProductionWebUrl:  URL! = URL(string: "https://signin.flipconnect.io/")
        static let connectProductionApiUrl: URL! = URL(string: "https://auth.flipconnect.io/api/")
        static let connectProductionUserManagementUrl: URL! = URL(string: "https://api.flipconnect.io/")
    }
}
