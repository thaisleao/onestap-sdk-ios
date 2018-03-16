//
//  UserDefaultsTests.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import XCTest
@testable import OnestapSDK

class UserDefaultsTests: XCTestCase {
    
    private struct consts {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let userKey = "userKey"
        static let authorizationCode = "authorizationCode"
    }
    
    override func setUp() {
        super.setUp()
        let conf = OSTConfiguration(clientId: "", clientSecret: "", scheme: "", host: "", isLogEnabled: true)
        _ = OST(configuration: conf)
        
        UserDefaults.standard.authenticationTokens = Authorization(refreshToken: consts.refreshToken, accessToken: consts.accessToken)
        UserDefaults.standard.userKey = consts.userKey
        UserDefaults.standard.authorizationCode = consts.authorizationCode
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        UserDefaults.standard.authenticationTokens = nil
        UserDefaults.standard.userKey = nil
        UserDefaults.standard.authorizationCode = nil
    }
    
    // Testes comentados por conta deste problema:
    // https://stackoverflow.com/questions/46299406/reading-from-keychain-xcode-9-simulators-returns-nothing/46317131#46317131
//    func testUserDefaultsAccessToken() {
//        XCTAssertFalse(UserDefaults.standard.accessToken == nil, "accessToken was not suposed to be nil")
//        XCTAssertTrue(UserDefaults.standard.accessToken == consts.accessToken)
//    }
//
//    func testUserDefaultsRefreshToken() {
//        XCTAssertFalse(UserDefaults.standard.refreshToken == nil, "refreshToken was not suposed to be nil")
//        XCTAssertTrue(UserDefaults.standard.refreshToken == consts.refreshToken)
//    }
//
//    func testUserDefaultsUserKey() {
//        XCTAssertFalse(UserDefaults.standard.userKey == nil, "userKey was not suposed to be nil")
//        XCTAssertTrue(UserDefaults.standard.userKey == consts.userKey)
//    }
    
    func testUserDefaultsAuthorizationCode() {
        XCTAssertFalse(UserDefaults.standard.authorizationCode == nil, "authorizationCode was not suposed to be nil")
        XCTAssertTrue(UserDefaults.standard.authorizationCode == consts.authorizationCode)
    }
}
