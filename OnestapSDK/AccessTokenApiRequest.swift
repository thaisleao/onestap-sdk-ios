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
        var url = OST.configuration.environment.apiURL
        url.appendPathComponent("oauth", isDirectory: true)
        url.appendPathComponent("token", isDirectory: false)
        
        let parameters = [
            "grant_type": "authorization_code",
            "authorization_code": "\(UserDefaults.standard.authorizationCode ?? "")",
            "redirect_uri": "\(OST.configuration.redirectUri)",
            "client_id": "\(OST.configuration.clientId)",
            "client_secret": "\(OST.configuration.clientSecret)"
        ]
        
        url.addParameters(parameters)
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.httpMethod = HttpVerbEnum.post.rawValue
        
        return request
    }
}
