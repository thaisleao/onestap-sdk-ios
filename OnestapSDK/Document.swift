//
//  Document.swift
//  OnestapSDK
//
//  Created by Munir Wanis on 22/08/17.
//  Copyright © 2017 Stone Payments. All rights reserved.
//

import Foundation

public struct Document {
    public var documentType: DocumentTypeEnum?
    public var documentTypeFriendlyName: String?
    public var documentNumber: String?
}

/// Possible Document Types for the API
public enum DocumentTypeEnum: String {
    /// CPF Document
    case cpf
    
    /// CNPJ Document
    case cnpj
    
    /// CNH Document
    case cnh
    
    /// Passport Document
    case passport
}
