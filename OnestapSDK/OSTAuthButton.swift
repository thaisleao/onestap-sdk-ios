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
        self.addTarget(nil, action: #selector(openLoginPage), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Opens Safari browser on one[S]tap login page
    @objc private func openLoginPage() {
        let url = RedirectHandlerImplementation.getLoginUrl(dataKey: OST.configuration.temporaryProfileDataKey)
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
