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
    
    /**
     Initialize our default button implementation
     - Parameters:
        - size: The size of the button (it's a square)
        - posX: The X position on canvas
        - posY: The Y position on canvas
    */
    public convenience init(size: CGFloat, posX x: CGFloat, posY y: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: size, height: size))
        self.titleLabel?.font = UIFont(name: "EuphemiaUCAS-Bold", size: size)
        self.setTitle("S", for: .normal)
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.adjustsImageWhenHighlighted = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        self.addTarget(nil, action: #selector(OST.shared.auth.loadAuthPage), for: .touchUpInside)
    }
}
