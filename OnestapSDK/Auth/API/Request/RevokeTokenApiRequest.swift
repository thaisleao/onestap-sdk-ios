//
//  RevokeTokenApiRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct RevokeTokenApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.authClientApiURL
        url.appendPathComponent("token", isDirectory: false)
        
        let parameters = [
            "grant_type": "revoke_token",
            "access_token": "\(UserDefaults.standard.accessToken ?? "")"
        ]
        
        url.addParameters(parameters)
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.addValue("basic \(OST.configuration.encodedClient)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HttpVerbEnum.post.rawValue
        return request
    }
}
