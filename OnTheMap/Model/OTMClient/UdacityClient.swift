//
//  OTMClient.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/19/21.
//

import UIKit

class UdacityClient: ParseClient {
    
    struct Auth {
        static var key = ""
        static var sessionId = ""
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
    }

    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"

        case signUp
        case login
        case getStudentLocations
        case getUserData
        case addStudentLocation

        var path: String {
            switch self {
            case .signUp: return "https://auth.udacity.com/sign-up"
            case .login: return Endpoints.base + "/session"
            case .getStudentLocations: return Endpoints.base + "/StudentLocation?order=-updatedAt&limit=100"
            case .getUserData: return Endpoints.base + "/users/" + Auth.key
            case .addStudentLocation: return Endpoints.base + "/StudentLocation"
            }
        }

        var url: URL {
            return URL(string: path)!
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let udacity = Udacity(username: username, password: password)
        let body = LoginRequest(udacity: udacity)
        super.taskForPOSTRequest(url: Endpoints.login.url,
                                          responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                Auth.key = response.account.key
                Auth.sessionId = response.session.sessionId
                UdacityClient().getUserData()
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func logout(completion: @escaping (Bool, Error?) -> Void) {
        super.taskForDELETERequest(url: Endpoints.login.url, responseType: LogoutResponse.self) { response, error in
            if response != nil {
                Auth.key = ""
                Auth.sessionId = ""
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

    func getStudentLocations(completion: @escaping (Bool, Error?) -> Void) {
        super.taskForGETRequest(url: Endpoints.getStudentLocations.url,
                                responseType: StudentLocationsResponse.self) { response, error in
            if let response = response {
                Student.locations = response.results
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func getUserData() {
        super.taskForGETRequest(url: Endpoints.getUserData.url,
                                responseType: UserResponse.self) { response, _ in
            if let response = response {
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
            }
        }
    }
    
    func addStudentInformation(studentInformation: StudentInformation, completion: @escaping (Bool, Error?) -> Void) {
        super.taskForPOSTRequest(url: Endpoints.addStudentLocation.url, responseType: AddLocationResponse.self, body: studentInformation) { response, error in
            if let response = response {
                Auth.objectId = response.objectId ?? ""
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
