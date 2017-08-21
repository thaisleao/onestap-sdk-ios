//
//  OSTAuthButton.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

class OSTAuthButton: OSTButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("Login with one[S]tap", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
