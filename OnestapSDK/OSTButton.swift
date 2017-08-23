//
//  OSTButton.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 21/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public class OSTButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.9, green: 0.170, blue: 0.54, alpha: 1.0)
        self.setTitleColor(UIColor(red: 0.5, green: 0.58, blue: 0.29, alpha: 1.0), for: .normal)
        self.layer.cornerRadius = 20
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
