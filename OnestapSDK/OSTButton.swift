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
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = UIColor.defaultGreen
        self.setTitleColor(UIColor.darkGreen, for: .normal)
        self.layer.cornerRadius = 8
        
    }
}

extension UIColor {
    static let defaultGreen: UIColor = UIColor(red: 0.57, green: 0.78, blue: 0.24, alpha: 1.0)
    static let darkGreen: UIColor = UIColor(red: 0.00, green: 0.22, blue: 0.13, alpha: 1.0)
}
