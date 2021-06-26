//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import Foundation

struct ErrorResponse: Codable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "status"
        case errorMessage = "error"
    }
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return errorMessage
    }
}
