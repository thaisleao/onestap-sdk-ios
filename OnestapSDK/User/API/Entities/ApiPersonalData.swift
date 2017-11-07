//
//  ApiPersonalData.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiPersonalData: InitializableWithData, InitializableWithJson {
    var birthdate: Date? = nil
    var genderType: GenderTypeEnum? = nil
    var country: String? = nil
    var dependentCount: Int? = nil
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        if let genderTypeString = json["genderType"] as? String {
            self.genderType = GenderTypeEnum(rawValue: genderTypeString)
        }
        
        self.birthdate = (json["birthdate"] as? String)?.toDate()
        self.country = json["country"] as? String
        self.dependentCount = json["dependentCount"] as? Int
    }
}

extension ApiPersonalData {
    var personalData: PersonalData {
        var personalData = PersonalData()
        personalData.birthdate = self.birthdate
        personalData.country = self.country
        personalData.dependentCount = self.dependentCount
        personalData.genderType = self.genderType
        return personalData
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}
