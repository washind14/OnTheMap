//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/20/21.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: Udacity
}

struct Udacity: Codable {
    let username: String
    let password: String

    enum CodingKeys: String, CodingKey {
    case username
    case password
    }
}
