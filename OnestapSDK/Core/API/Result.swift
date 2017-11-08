//
//  Result.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 17/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
}

public enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
