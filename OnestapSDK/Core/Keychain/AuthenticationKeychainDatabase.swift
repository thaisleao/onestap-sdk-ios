//
//  AuthenticationKeychainDatabase.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 15/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

class AuthenticationKeychainDatabase {
    private let keychainDatabase: KeychainDatabaseProtocol
    
    init() {
        let keychainDB = KeychainDatabase(configuration: KeychainConfiguration(dataName: "ONSTTokens"))
        self.keychainDatabase = keychainDB
    }
    
    /**
     Saves `refreshToken` to local storage
     - Parameters:
        - tokens: The refresh token you want to save
     - Throws: `KeychainError` if the store fails
     */
    func store(tokens: Authorization) throws {
        try keychainDatabase.save(item: tokens)
    }
    
    /**
     Gets `accessToken` and `refreshToken` from local storage
     - Returns: `Authentication` object
     - Throws: `KeychainError` if the retrieving fails
     */
    func getTokens() throws -> Authorization {
        let tokens: Authorization = try keychainDatabase.read()
        return tokens
    }
    
    /// Deletes tokens from Keychain
    func deleteTokens() {
        keychainDatabase.clean()
    }
}
