//
//  RefreshTokenRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct RefreshTokenRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url: URL! = URL(string: OST.configuration.environment.apiURL)
        var request = URLRequest(url: url)
        
        request.httpMethod = HttpVerbEnum.post.rawValue
        
        return request
    }
}
