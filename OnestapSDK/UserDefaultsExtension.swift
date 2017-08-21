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
        static let AccessToken = "OSTAccessToken"
        static let RefreshToken = "OSTRefreshToken"
        static let UserKey = "OSTUserKey"
        static let FingerPrintSessionID = "OSTRLFingerPrintSessionID"
    }
    
    internal var authorizationCode: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AuthorizationCode)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AuthorizationCode)
        }
    }
    
    /// Token used to make requests to one[S]tap
    public internal(set) var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AccessToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AccessToken)
        }
    }
    
    /// Token used to refresh user session
    public internal(set) var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.RefreshToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.RefreshToken)
        }
    }
    
    /// UserKey is the key of the User
    public internal(set) var userKey: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.UserKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.UserKey)
        }
    }
    
    /// fingerPrintSessionID is the ID generated for the session of the user
    public internal(set) var fingerPrintSessionID: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.FingerPrintSessionID)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.FingerPrintSessionID)
        }
    }
}
