//
//  UserKeyKeychainDatabase.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 15/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

class UserKeyKeychainDatabase {
    private let keychainDatabase: KeychainDatabaseProtocol
    
    init() {
        self.keychainDatabase = KeychainDatabase(configuration: KeychainConfiguration(dataName: "ONSTUserKey"))
    }
    
    /**
     Saves `refreshToken` to local storage
     - Parameters:
        - userKey: The refresh token you want to save
     - Throws: `KeychainError` if the store fails
     */
    func store(_ userKey: String) throws {
        try keychainDatabase.save(text: userKey)
    }
    
    /**
     Gets `userKey` from local storage
     - Returns: `String` object
     - Throws: `KeychainError` if the retrieving fails
     */
    func getUserKey() throws -> String {
        let userKey = try keychainDatabase.read()
        return userKey
    }
    
    /// Deletes UserKey from Keychain
    func deleteUserKey() {
        keychainDatabase.clean()
    }
}
