//
//  UserDefaultsExtension.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let AuthorizationCode = "OSTAuthorizationCode"
        static let FingerPrintSessionId = "OSRLFingerPrintSessionId"
    }
    
    private struct KeychainDatabases {
        static let authorizationDB = AuthenticationKeychainDatabase()
        static let userKeyDB = UserKeyKeychainDatabase()
    }
    
    internal var authorizationCode: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AuthorizationCode)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AuthorizationCode)
        }
    }
    
    var authenticationTokens: Authorization? {
        get {
            return try? KeychainDatabases.authorizationDB.getTokens()
        } set {
            guard let tokens = newValue else { return KeychainDatabases.authorizationDB.deleteTokens() }
            try? KeychainDatabases.authorizationDB.store(tokens: tokens)
        }
    }
    
    /// Token used to make requests to one[S]tap
    public internal(set) var accessToken: String? {
        get {
            return authenticationTokens?.accessToken
        } set {
            guard var tokens = authenticationTokens, let accessToken = newValue else { return }
            tokens.accessToken = accessToken
            authenticationTokens = tokens
        }
    }
    
    /// Token used to refresh user session
    public var refreshToken: String? {
        return authenticationTokens?.refreshToken
    }
    
    /// UserKey is the key of the User
    public internal(set) var userKey: String? {
        get {
            return try? KeychainDatabases.userKeyDB.getUserKey()
        } set {
            guard let key = newValue else { return KeychainDatabases.userKeyDB.deleteUserKey() }
            try? KeychainDatabases.userKeyDB.store(key)
        }
    }
    
    /// FingerPrintSessionId is created when anti-fraud is enabled
    public internal(set) var fingerPrintSessionId: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.FingerPrintSessionId)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.FingerPrintSessionId)
        }
    }
}
