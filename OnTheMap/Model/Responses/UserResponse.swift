//
//  UserResponse.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/20/21.
//

import Foundation

struct UserResponse: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
