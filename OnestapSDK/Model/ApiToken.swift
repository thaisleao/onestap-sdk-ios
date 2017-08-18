//
//  ApiToken.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiToken: Response, InitializableWithData, InitializableWithJson {
    var success: Bool = false
    var operationReport: [ApiReport] = []
    var accessToken: String?
    var refreshToken: String?
    var userKey: String?
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        try initializeResponse(json: json)
        self.userKey = json["userKey"] as? String
        self.accessToken = json["accessToken"] as? String
        self.refreshToken = json["refreshToken"] as? String
    }
}

extension ApiToken {
    var token: Token {
        return Token(accessToken: accessToken, refreshToken: refreshToken, userKey: userKey)
    }
}
