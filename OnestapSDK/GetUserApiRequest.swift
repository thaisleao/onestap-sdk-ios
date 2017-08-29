//
//  GetUserApiRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct GetUserApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.userManagementURL
        url.appendPathComponent("user", isDirectory: true)
        url.appendPathComponent("account", isDirectory: false)
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        request.httpMethod = HttpVerbEnum.get.rawValue
        request.httpBody = OST.configuration.temporaryProfile?.toJsonData()
        return request
    }
}
