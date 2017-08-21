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
        var url: URL! = URL(string: OST.configuration.environment.apiURL)
        
        let parameters = [
            "grant_type": "refresh_token",
            "refresh_token": "\(UserDefaults.standard.refreshToken ?? "")",
            "client_id": "\(OST.configuration.clientId)",
            "client_secret": "\(OST.configuration.clientSecret)",
            "redirect_uri": "\(OST.configuration.redirectUri)"
        ]
        
        url.addParameters(parameters)
        
        var request = URLRequest(url: url)
        
        request.addDefaultHeaders()
        
        request.httpMethod = HttpVerbEnum.post.rawValue
        
        return request
    }
}
