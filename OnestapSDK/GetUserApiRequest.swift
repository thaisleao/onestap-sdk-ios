//
//  GetUserApiRequest.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct GetUserApiRequest: ApiRequest {
    
    private var includePersonalData: Bool
    private var includeEmails: Bool
    private var includePhones: Bool
    private var includeAddresses: Bool
    private var includeDocuments: Bool
    
    init(includePersonalData: Bool, includeEmails: Bool, includePhones: Bool, includeAddresses: Bool, includeDocuments: Bool) {
        self.includePersonalData = includePersonalData
        self.includeEmails = includeEmails
        self.includePhones = includePhones
        self.includeAddresses = includeAddresses
        self.includeDocuments = includeDocuments
    }
    
    var urlRequest: URLRequest {
        var url = OST.configuration.environment.userManagementURL
        url.appendPathComponent("user", isDirectory: true)
        url.appendPathComponent("account", isDirectory: false)
        
        if includePersonalData { url.addParameter("personalData", forParameterName: "include") }
        if includeEmails { url.addParameter("emails", forParameterName: "include") }
        if includePhones { url.addParameter("phones", forParameterName: "include") }
        if includeAddresses { url.addParameter("addresses", forParameterName: "include") }
        if includeDocuments { url.addParameter("documents", forParameterName: "include") }
        
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        
        if let accessToken = UserDefaults.standard.accessToken {
            request.addValue("bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        request.httpMethod = HttpVerbEnum.get.rawValue
        return request
    }
}
