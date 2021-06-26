//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/20/21.
//


import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Session: Codable {
    let sessionId: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "id"
        case expiration
    }
}

struct Account: Codable {
    let registered: Bool
    let key: String
}
