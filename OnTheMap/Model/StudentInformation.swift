//
//  StudentId.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import Foundation

struct StudentInformation: Codable {
    let firstName: String
    var lastName: String
    var longitude: Double
    var latitude: Double
    var mapString: String
    var mediaURL: String
    var uniqueKey: String
    var objectId: String
    var createdAt: String
    var updatedAt: String
}
