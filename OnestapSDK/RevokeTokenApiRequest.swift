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
        var url: URL! = URL(string: OST.configuration.environment.apiURL)
        
        let parameters = [
            "grant_type": "revoke_token",
            "access_token": "\(UserDefaults.standard.accessToken ?? "")",
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
