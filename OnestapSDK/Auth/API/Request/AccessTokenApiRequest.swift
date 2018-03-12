//
//  AccessTokenApiRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct AccessTokenApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.authClientApiURL
        url.appendPathComponent("token", isDirectory: false)
        
        let parameters = [
            "grant_type": "authorization_code",
            "authorization_code": "\(UserDefaults.standard.authorizationCode ?? "")",
            "redirect_uri": "\(OST.configuration.redirectUri)",
            "state": "123456"
        ]
        
        url.addParameters(parameters)
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.addValue("basic \(OST.configuration.encodedClient)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HttpVerbEnum.post.rawValue
        
        return request
    }
}
