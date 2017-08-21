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
        var url: URL! = URL(string: OST.configuration.environment.apiURL)
        
        let parameters = [
            "grant_type": "authorization_code",
            "authorization_code": "\(UserDefaults.standard.authorizationCode ?? "")",
            "redirect_uri": "\(OST.configuration.redirectUri)",
            "client_secret": "\(OST.configuration.clientSecret)",
            "client_id": "\(OST.configuration.clientId)"
        ]
        
        url.addParameters(parameters)
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.httpMethod = HttpVerbEnum.post.rawValue
        
        return request
    }
}
