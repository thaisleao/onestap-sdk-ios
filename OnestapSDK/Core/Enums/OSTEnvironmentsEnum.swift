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
            switch self {
            case .production:
                return ApiUrls.onestapProductionWebUrl
            case .sandbox:
                if ApiUrls.isStaging { fallthrough }
                return ApiUrls.onestapSandboxWebUrl
            default:
                return ApiUrls.onestapStagingWebUrl
            }
        }
    }
    
    /**
     Return API URL to communicate with the Authentication API
     */
    internal var apiURL: URL {
        get {
            switch self {
            case .production:
                return ApiUrls.onestapProductionApiUrl
            case .sandbox:
                if ApiUrls.isStaging { fallthrough }
                return ApiUrls.onestapSandboxApiUrl
            default:
                return ApiUrls.onestapStagingApiUrl
            }
        }
    }
    
    /**
     Return API URL to communicate with the Management API
     */
    internal var userManagementURL: URL {
        get {
            switch self {
            case .production:
                return ApiUrls.onestapProductionUserManagementUrl
            case .sandbox:
                if ApiUrls.isStaging { fallthrough }
                return ApiUrls.onestapSandboxUserManagementUrl
            default:
                return ApiUrls.onestapStagingUserManagementUrl
            }
        }
    }
    
    private struct ApiUrls {
        static var isStaging: Bool = false
        
        static let onestapStagingWebUrl: URL! = URL(string: "http://flipconnect-signin-develop.herokuapp.com/")
        static let onestapStagingApiUrl: URL! = URL(string: "http://dlp-qrservices.cloudapp.net:20112/api/")
        static let onestapStagingUserManagementUrl: URL! = URL(string: "http://dlp-qrservices.cloudapp.net:20115/")
        
        static let onestapSandboxWebUrl: URL! = URL(string: "https://signin-sandbox.onestap.com/")
        static let onestapSandboxApiUrl: URL! = URL(string: "https://auth-sandbox.onestap.com/api/")
        static let onestapSandboxUserManagementUrl: URL! = URL(string: "https://api-sandbox.onestap.com/")
        
        static let onestapProductionWebUrl:  URL! = URL(string: "https://signin.onestap.com/")
        static let onestapProductionApiUrl: URL! = URL(string: "https://auth.onestap.com/api/")
        static let onestapProductionUserManagementUrl: URL! = URL(string: "https://api.onestap.com/")
    }
}
