//
//  JSON.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 17/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

/**
 Extension on `Dictionary` that adds different helper methods such as JSON `Data` serialization
 */
extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
    
    /**
     Heper method that serializes the `Dictionary` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    public func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

/**
 Extension on `Array` that adds different helper methods such as JSON `Data` serialization
 */
extension Array where Element: Any {
    /**
     Heper method that serializes the `Array` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    public func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}
