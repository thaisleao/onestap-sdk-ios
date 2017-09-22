//
//  RedirectHandlerTests.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/09/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import XCTest
@testable import OnestapSDK

class RedirectHandlerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRedirectHandleImplementationConfigNotFoundError() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        do {
            _ = try RedirectHandlerImplementation(bundle: nil)
        } catch {
            switch error {
            case OSTErrors.plistNotFound:
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
    }
}
