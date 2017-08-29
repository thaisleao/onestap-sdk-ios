//
//  ApiPublicProfile.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiPublicProfile: InitializableWithData, InitializableWithJson {
    var name: String?
    var pictureUrl: String?
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        self.name = json["name"] as? String
        self.pictureUrl = json["pictureUrl"] as? String
    }
}
