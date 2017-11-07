//
//  RedirectHandler.swift
//  OnestapSDK
//
//  Created by Jaison Vieira on 11/10/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

protocol RedirectHandler {
    init(bundle: JSON?) throws
    static var state: String { get set }
    static func getLoginUrl(dataKey: String?) -> URL
    func handleUri(open url: URL) throws
}

struct RedirectHandlerImplementation: RedirectHandler {
    private static let sdkIdentifier = "OnestapSDK"
    private static let urlNameKey = "CFBundleURLName"
    private let urlTypeKey = "CFBundleURLTypes"
    private static let urlSchemeKey = "CFBundleURLSchemes"
    private let urlQueryStateKey = "state"
    private let urlQueryAuthCodeKey = "code"
    private let authorizeOperation = "authorize"
    
    private var plist: JSON = [:]
    private var config: [JSON] = [[:]]
    
    internal static var state: String = ""
    
    /// Scheme used for DeepLinking
    private let urlScheme: String
    
    init(bundle: JSON?) throws {
        
        guard let plist = bundle else {
            throw OSTErrors.plistNotFound
        }
        
        guard let config = plist[urlTypeKey] as? [JSON], !config.isEmpty else {
            throw OSTErrors.configNotFound
        }
        
        self.plist = plist
        self.config = config
        self.urlScheme = try RedirectHandlerImplementation.getScheme(from: config)
    }
    
    private static func getScheme(from cfBundleURLTypes: [JSON]) throws -> String {
        
        let scheme: String = cfBundleURLTypes.flatMap {
            if ($0[urlNameKey] as? String) == sdkIdentifier {
                return ($0[urlSchemeKey] as? [String])?.first
            }
            return nil
            }.first ?? ""
        
        if scheme.isEmpty { throw OSTErrors.failedToRetrieveSchemeFromPlist }
        
        return scheme
    }
    
    static func getLoginUrl(dataKey: String? = nil) -> URL {
        RedirectHandlerImplementation.state = UUID().uuidString
        var url = OST.configuration.environment.webURL
        url.addParameter(OST.configuration.clientId, forParameterName: "client_id")
        url.addParameter(OST.configuration.redirectUri, forParameterName: "redirect_uri")
        url.addParameter(RedirectHandlerImplementation.state, forParameterName: "state")
        url.addParameter("code", forParameterName: "response_type")
        if let dataKey = dataKey {
            url.addParameter(dataKey, forParameterName: "data_key")
        }
        return url
    }
    
    func handleUri(open url: URL) throws {
        guard url.scheme?.lowercased() == self.urlScheme else {
            // it don't throws because it can be any URL
            return
        }
        
        let urlComponents = URLComponents(string: url.absoluteString)
        
        guard let items = urlComponents!.queryItems else {
            throw OSTErrors.malformedUri
        }
        
        // Verify if the state is valid
        let stateValue = items.filter{ $0.name.lowercased() == urlQueryStateKey }.first?.value
        guard let state = stateValue, state == RedirectHandlerImplementation.state else {
            throw OSTErrors.stateIsInvalid
        }
        
        //deeplink://something?operation=authorize&code=f117d5fe-a5ef-40bd-b171-55c8210c1cbd&state=undefined
        guard let operation = items.first?.value else {
            throw OSTErrors.invalidOperation
        }
        
        switch operation {
        case authorizeOperation:
            try handleAuthorizeRedirect(queryItems: items)
        default:
            throw OSTErrors.invalidOperation
        }
    }
    
    private func handleAuthorizeRedirect(queryItems items: [URLQueryItem]) throws {
        let authorizationCode = items.filter{ $0.name == urlQueryAuthCodeKey }.first
        
        guard let propertyValue = authorizationCode?.value else {
            throw OSTErrors.wrongParameters(message: "\(urlQueryAuthCodeKey) was not found as a parameter")
        }
        
        UserDefaults.standard.authorizationCode = propertyValue
    }
}
