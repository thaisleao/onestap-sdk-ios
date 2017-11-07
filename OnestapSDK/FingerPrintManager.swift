//
//  FingerPrintManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 25/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation
import FingerPrint_iOS

protocol FingerPrintManager {
    func sendFingerPrint()
}

class FingerPrintManagerImplementation: FingerPrintManager {
    var sessionId: String
    
    init() {
        self.sessionId = UUID().uuidString
        UserDefaults.standard.fingerPrintSessionId = self.sessionId
    }
    
    func sendFingerPrint() {
        guard let fingerPrintId = OST.configuration.fingerPrintId,
              let accessToken = UserDefaults.standard.accessToken, let userKey = UserDefaults.standard.userKey else {
            return
        }

        FingerPrintLibrary.initFingerprint(role: OST.configuration.environment.rawValue,
                                           key: fingerPrintId,
                                           registerId: userKey,
                                           sessionId: self.sessionId)
        FingerPrintLibrary.configFingerprint(phoneData: true, contactList: true, location: true)
        FingerPrintLibrary.getFingerprint()
    }
}
