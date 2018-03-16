//
//  RefreshTokenRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct RefreshTokenApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.authClientApiURL
        url.appendPathComponent("token", isDirectory: false)
        
        let parameters = [
            "grant_type": "refresh_token",
            "refresh_token": "\(UserDefaults.standard.refreshToken ?? "")"
        ]
        
        url.addParameters(parameters)
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.addValue("basic \(OST.configuration.encodedClient)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HttpVerbEnum.post.rawValue
        return request
    }
}
