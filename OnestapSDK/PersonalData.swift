//
//  PersonalData.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct PersonalData {
    public var birthdate: Date?
    public var genderType: GenderTypeEnum?
    public var country: String?
    public var dependentCount: Int?
}

/// Gender of the Person
public enum GenderTypeEnum: String {
    case masculine
    case feminine
    case unmentioned
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
