//
//  KeychainDatabaseProtocol.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 15/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

protocol KeychainDatabaseProtocol {
    
    
    /// Reads data stored on Keychain
    ///
    /// - Returns: `Decodable` type object
    /// - Throws: `OnestapError` when the request is not successfull
    func read<T>() throws -> T where T: Decodable
    
    
    /// Reads data stored on Keychain
    ///
    /// - Returns: Text
    /// - Throws: `OnestapError` when the request is not successfull
    func read() throws -> String
    
    
    /// Saves data on Keychain
    ///
    /// - Parameter text: Text you want to save
    /// - Throws: `OnestapError` when the request is not successfull
    func save(text: String) throws
    
    /// Saves data on Keychain
    ///
    /// - Parameter item: `Encodable` must be inferred on the object you're trying to save
    /// - Throws: `OnestapError` when the request is not successfull
    func save<T>(item: T) throws where T: Encodable
    
    
    /// Deletes the data stored on Keychain
    func clean()
    
    /// Initialize the database with your configurations
    ///
    /// - Parameter configuration: Protocol that contains the necessary information to save data to Keychain
    init(configuration: KeychainConfigurable)
}
