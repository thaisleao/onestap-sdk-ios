//
//  TokenManager.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

protocol TokenManager {
    func refreshToken(completion: @escaping (_ tokens: Result<Token>) -> Void)
}
