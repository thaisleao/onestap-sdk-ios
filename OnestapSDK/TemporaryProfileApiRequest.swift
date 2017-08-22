//
//  TemporaryProfileApiRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct TemporaryProfileApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.userManagementURL
        url.appendPathExtension("user")
        url.appendPathExtension("temporaryProfile")
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.httpMethod = HttpVerbEnum.post.rawValue
        request.httpBody = OST.configuration.temporaryProfile?.toJsonData()
        return request
    }
}
