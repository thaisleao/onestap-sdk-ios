//
//  ApiUserTests.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 30/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import XCTest
@testable import OnestapSDK

class ApiUserTests: XCTestCase {
    
    var accountJSON: String!
    
    override func setUp() {
        super.setUp()
        self.accountJSON = "{\"account\":{\"accountKey\":\"424d061e-db81-e711-80de-1418772b6962\",\"isEnabled\":true,\"isNewsLetterAllowed\":false,\"publicProfile\":{\"name\":\"Ipiranga\",\"pictureUrl\":null},\"personalData\":{\"birthdate\":\"2017-08-15\",\"genderType\":\"masculine\",\"genderTypeFriendlyName\":\"Masculine\",\"dependentCount\":null,\"country\":\"BR\"},\"emails\":[{\"key\":\"434d061e-db81-e711-80de-1418772b6962\",\"address\":\"ipiranga@mailinator.com\",\"isValidated\":true,\"isPrimary\":false}],\"phones\":[{\"key\":\"daaaf5e1-e681-e711-80de-1418772b6962\",\"phoneType\":\"home\",\"phoneTypeFriendlyName\":\"Home\",\"fullNumber\":\"+552132118970\",\"isValidated\":false,\"isPrimary\":false}],\"addresses\":[{\"key\":\"d8aaf5e1-e681-e711-80de-1418772b6962\",\"street\":\"Rua Teófilo Otoni\",\"number\":\"63\",\"complement\":null,\"addressType\":\"home\",\"addressTypeFriendlyName\":\"Home\",\"district\":\"Centro\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"20090080\",\"addressReference\":null,\"country\":\"BR\"},{\"key\":\"88d2fa3c-fb81-e711-80de-1418772b6962\",\"street\":\"Rua Teófilo Otoni\",\"number\":\"63\",\"complement\":null,\"addressType\":\"home\",\"addressTypeFriendlyName\":\"Home\",\"district\":\"Centro\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"20090080\",\"addressReference\":null,\"country\":\"BR\"},{\"key\":\"f3b7a64b-fb81-e711-80de-1418772b6962\",\"street\":\"Rua Teófilo Otoni\",\"number\":\"63\",\"complement\":null,\"addressType\":\"home\",\"addressTypeFriendlyName\":\"Home\",\"district\":\"Centro\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"20090080\",\"addressReference\":null,\"country\":\"BR\"}],\"documents\":[{\"key\":\"d9aaf5e1-e681-e711-80de-1418772b6962\",\"documentType\":\"cpf\",\"documentTypeFriendlyName\":\"CPF\",\"documentNumber\":\"93153012423\",\"documentData\":null}]},\"success\":true,\"operationReport\":[]}"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApiAccountJsonToObject() {
        let data = self.accountJSON.data(using: String.Encoding.utf8)
        let apiAccount = try? ApiAccount(data: data)
        XCTAssert(apiAccount?.accountKey == "424d061e-db81-e711-80de-1418772b6962")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
