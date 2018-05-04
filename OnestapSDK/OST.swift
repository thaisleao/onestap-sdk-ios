//
//  OST.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 18/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class OST {
    static var configuration: OSTConfiguration!
    
    public static var shared: OST!
    
//    let fingerPrint = FingerPrintManagerImplementation()
    
    public required init(configuration: OSTConfiguration) {
        OST.configuration = configuration        
        OST.shared = self
        
        if UserDefaults.standard.isSavedToKeychain == false {
            Log.message("Dumping data saved on Keychain")
            OST.shared.dump()
        }
        
        UserDefaults.standard.isSavedToKeychain = true
//        fingerPrint.sendFingerPrint()
    }
}


// MARK: Private methods

extension OST {
    private func dump() {
        UserDefaults.standard.authenticationTokens = nil
        UserDefaults.standard.userKey = nil
    }
}
