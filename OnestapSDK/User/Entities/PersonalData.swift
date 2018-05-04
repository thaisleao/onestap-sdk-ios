//
//  PersonalData.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct PersonalData {
    public init() {}
    public var birthdate: Date?
    public var genderType: GenderTypeEnum?
    public var country: String?
    public var dependentCount: Int?
}

extension PersonalData: Encondable {
    func toDictionary() -> JSON {
        return [
            "birthdate": birthdate?.toString() as Any,
            "genderType": genderType?.rawValue as Any,
            "country": country as Any,
            "dependentCount": dependentCount as Any
        ]
    }
}

/// Gender of the Person
public enum GenderTypeEnum: String {
    @available(*, deprecated, renamed: "male")
    case masculine
    
    @available(*, deprecated, renamed: "female")
    case feminine
    
    case male
    case female
    case unmentioned
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
