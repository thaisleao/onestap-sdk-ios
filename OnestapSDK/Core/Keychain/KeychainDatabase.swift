//
//  KeychainDatabase.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 15/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

// MARK: Types
fileprivate enum KeychainError: Error {
    case noData
    case unexpectedData
    case unexpectedItemData
    case unhandledError(status: OSStatus)
}

public struct KeychainDatabase {
    
    // MARK: Properties
    
    let service: String
    
    private(set) var dataName: String
    
    let accessGroup: String?
    
    // MARK: Intialization
    
    public init(configuration: KeychainConfigurable) {
        self.service = configuration.serviceName
        self.dataName = configuration.dataName
        self.accessGroup = configuration.accessGroup
    }
    
    private init(service: String, dataName: String, accessGroup: String? = nil) {
        self.service = service
        self.dataName = dataName
        self.accessGroup = accessGroup
    }
}

// MARK: - Public methods
extension KeychainDatabase: KeychainDatabaseProtocol {
    public func read<T>() throws -> T where T: Decodable {
        do {
            let data = try getItem()
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            switch error {
            case KeychainError.unhandledError(status: let status): Log.message("Keychain - Failed to save data, status: \(status)")
            default: Log.message("Keychain - Failed to save data, error: \(error)")
            }
            throw error
        }
    }
    
    public func read() throws -> String {
        do {
            let data = try getItem()
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            switch error {
            case KeychainError.unhandledError(status: let status): Log.message("Keychain - Failed to save data, status: \(status)")
            default: Log.message("Keychain - Failed to save data, error: \(error)")
            }
            throw error
        }
    }
    
    public func save<T>(item: T) throws where T: Encodable {
        do {
            let data = try JSONEncoder().encode(item)
            try saveData(item: data)
        } catch {
            switch error {
            case KeychainError.unhandledError(status: let status): Log.message("Keychain - Failed to save data, status: \(status)")
            default: Log.message("Keychain - Failed to save data, error: \(error)")
            }
            throw error
        }
    }
    
    public func save(text: String) throws {
        do {
            guard let data = text.data(using: .utf8) else { throw KeychainError.noData }
            try saveData(item: data)
        } catch {
            switch error {
            case KeychainError.unhandledError(status: let status): Log.message("Keychain - Failed to save data, status: \(status)")
            default: Log.message("Keychain - Failed to save data, error: \(error)")
            }
            throw error
        }
    }
    
    public func clean() {
        do { try deleteItem() }
        catch {
            switch error {
            case KeychainError.unhandledError(status: let status): Log.message("Keychain - Failed to save data, status: \(status)")
            default: Log.message("Keychain - Failed to save data, error: \(error)")
            }
        }
    }
}

// MARK: - Private methods
extension KeychainDatabase {
    // MARK: Keychain access
    
    fileprivate func getItem() throws -> Data {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeychainDatabase.keychainQuery(withService: service, account: dataName, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noData }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String : AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data
            else {
                throw KeychainError.unexpectedData
        }
        
        return passwordData
    }
    
    fileprivate func saveData(item data: Data) throws {
        do {
            // Check for an existing item in the keychain.
            try _ = getItem()
            
            // Update the existing item with the new password.
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = data as AnyObject?
            
            let query = KeychainDatabase.keychainQuery(withService: service, account: dataName, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
        catch KeychainError.noData {
            /*
             No password was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = KeychainDatabase.keychainQuery(withService: service, account: dataName, accessGroup: accessGroup)
            newItem[kSecValueData as String] = data as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }
    
    fileprivate mutating func rename(account newAccountName: String) throws {
        // Try to update an existing item with the new account name.
        var attributesToUpdate = [String : AnyObject]()
        attributesToUpdate[kSecAttrAccount as String] = newAccountName as AnyObject?
        
        let query = KeychainDatabase.keychainQuery(withService: service, account: self.dataName, accessGroup: accessGroup)
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
        
        self.dataName = newAccountName
    }
    
    fileprivate func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeychainDatabase.keychainQuery(withService: service, account: dataName, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
    fileprivate static func retrieveItems(forService service: String, accessGroup: String? = nil) throws -> [KeychainDatabase] {
        // Build a query for all items that match the service and access group.
        var query = KeychainDatabase.keychainQuery(withService: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanFalse
        
        // Fetch matching items from the keychain.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return [] }
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String : AnyObject]] else { throw KeychainError.unexpectedItemData }
        
        // Create a `KeychainPasswordItem` for each dictionary in the query result.
        var passwordItems = [KeychainDatabase]()
        for result in resultData {
            guard let account  = result[kSecAttrAccount as String] as? String else { throw KeychainError.unexpectedItemData }
            
            let passwordItem = KeychainDatabase(service: service, dataName: account, accessGroup: accessGroup)
            passwordItems.append(passwordItem)
        }
        
        return passwordItems
    }
    
    // MARK: Convenience
    
    fileprivate static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
