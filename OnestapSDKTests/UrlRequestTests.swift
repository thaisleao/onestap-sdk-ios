//
//  UrlRequestTests.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import XCTest
@testable import OnestapSDK

class UrlRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let url = URL(string: "https://www.google.com/")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addDefaultHeaders()
        
        XCTAssertTrue(urlRequest.allHTTPHeaderFields?.count == 3)
    }
}
