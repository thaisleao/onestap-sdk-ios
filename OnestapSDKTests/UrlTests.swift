//
//  UrlTests.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import XCTest
@testable import OnestapSDK

class UrlTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUrlAddParameter() {
        var url = URL(string: "https://www.google.com/test")!
        
        url.addParameter("hey", forParameterName: "greeting")
        
        XCTAssertTrue(url.absoluteString == "https://www.google.com/test?greeting=hey")
    }
    
    func testUrlAddParameters() {
        var url = URL(string: "https://www.google.com/test")!
        
        let parameters = [
            "greeting": "hey",
            "istestenabled": "true"
        ]
        
        url.addParameters(parameters)
        
        XCTAssertTrue(url.absoluteString == "https://www.google.com/test?greeting=hey&istestenabled=true")
    }
}
