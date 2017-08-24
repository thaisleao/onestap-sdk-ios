//
//  OSTAuthButton.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class OSTAuthButton: OSTButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        self.setTitle("Login with one[s]tap", for: .normal)
        self.addTarget(nil, action: #selector(openLoginPage), for: .touchUpInside)
    }
    
    /// Opens Safari browser on one[S]tap login page
    @objc private func openLoginPage() {
        let url = RedirectHandlerImplementation.getLoginUrl(dataKey: OST.configuration.temporaryProfileDataKey)
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
