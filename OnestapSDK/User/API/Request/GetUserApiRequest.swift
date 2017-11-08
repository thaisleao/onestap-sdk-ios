//
//  GetUserApiRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct GetUserApiRequest: ApiRequest {
    
    private var categories: [OSTCategoriesEnum]
    
    init(categories: [OSTCategoriesEnum]) {
        self.categories = Array(Set(categories))
    }
    
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.userManagementURL
        url.appendPathComponent("user", isDirectory: true)
        url.appendPathComponent("account", isDirectory: false)
        
        self.categories.forEach { url.addParameter($0.rawValue, forParameterName: "include") }
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        
        if let accessToken = UserDefaults.standard.accessToken {
            request.addValue("bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        request.httpMethod = HttpVerbEnum.get.rawValue
        return request
    }
}
