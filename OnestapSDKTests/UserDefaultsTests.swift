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
        UserDefaults.standard.accessToken = consts.accessToken
        UserDefaults.standard.refreshToken = consts.refreshToken
        UserDefaults.standard.userKey = consts.userKey
        UserDefaults.standard.authorizationCode = consts.authorizationCode
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        UserDefaults.standard.accessToken = nil
        UserDefaults.standard.refreshToken = nil
        UserDefaults.standard.userKey = nil
        UserDefaults.standard.authorizationCode = nil
    }
    
    func testUserDefaultsAccessToken() {
        XCTAssertFalse(UserDefaults.standard.accessToken == nil, "accessToken was not suposed to be nil")
        XCTAssertTrue(UserDefaults.standard.accessToken == consts.accessToken)
    }
    
    func testUserDefaultsRefreshToken() {
        XCTAssertFalse(UserDefaults.standard.refreshToken == nil, "refreshToken was not suposed to be nil")
        XCTAssertTrue(UserDefaults.standard.refreshToken == consts.refreshToken)
    }
    
    func testUserDefaultsUserKey() {
        XCTAssertFalse(UserDefaults.standard.userKey == nil, "userKey was not suposed to be nil")
        XCTAssertTrue(UserDefaults.standard.userKey == consts.userKey)
    }
    
    func testUserDefaultsAuthorizationCode() {
        XCTAssertFalse(UserDefaults.standard.authorizationCode == nil, "authorizationCode was not suposed to be nil")
        XCTAssertTrue(UserDefaults.standard.authorizationCode == consts.authorizationCode)
    }
}
