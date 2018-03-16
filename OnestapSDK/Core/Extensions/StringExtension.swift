//
//  StringExtension.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 12/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

extension String {
    internal func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
