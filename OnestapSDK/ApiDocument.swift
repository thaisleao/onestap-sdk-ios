//
//  ApiDocument.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 29/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

struct ApiDocument: InitializableWithData, InitializableWithJson {
    var key: String = ""
    var documentType: DocumentTypeEnum
    var documentNumber: String
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? JSON else {
                throw NSError.createParseError()
        }
        try self.init(json: json)
    }
    
    init(json: JSON) throws {
        guard let key = json["key"] as? String,
            let documentTypeString = json["documentType"] as? String,
            let documentType = DocumentTypeEnum(rawValue: documentTypeString),
            let documentNumber = json["documentNumber"] as? String else {
                throw NSError.createParseError()
        }
        
        self.key = key
        self.documentType = documentType
        self.documentNumber = documentNumber
    }
}

extension ApiDocument {
    var document: Document {
        var document = Document(documentType: self.documentType, documentNumber: self.documentNumber)
        document.key = self.key
        return document
    }
}
