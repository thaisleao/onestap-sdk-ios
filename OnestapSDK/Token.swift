//
//  Token.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Token {
    /// Token to access the API
    public var accessToken: String?
    
    /// Token used to update your accessToken
    public var refreshToken: String?
    
    /// Key used to get user data
    public var userKey: String?
}
