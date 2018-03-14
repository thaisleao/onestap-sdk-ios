//
//  BundleExtension.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 14/03/18.
//  Copyright © 2018 Stone Payments. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String {
        return infoDictionary?[kCFBundleNameKey as String] as? String ?? "{APPLICATION_NAME}"
    }
    
    var shortVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var buildVersion: String {
        return infoDictionary?[kCFBundleVersionKey as String] as? String ?? ""
    }
    
    var versionAndBuild: String {
        return "\(shortVersion)/\(buildVersion)"
    }
    
    static var sdkBundle: Bundle {
        return Bundle.init(identifier: "com.onestap.OnestapSDK")!
    }
}
