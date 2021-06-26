//
//  Parse.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/20/21.
//

import Foundation

class ParseClient: Loadable {
    
    func trimUdacityResponse(_ data: Data) -> Data {
        let range = 5..<data.count
        let newData = data.subdata(in: range)
        return newData
    }
    
    func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(
        url: URL, responseType: ResponseType.Type, body: RequestType,
        completion: @escaping (ResponseType?, Error?) -> Void) {
        startLoading()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let json = try JSONEncoder().encode(body)
            request.httpBody = json
        } catch {
            DispatchQueue.main.async {
                self.stopLoading()
                completion(nil, error)
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            if responseType == LoginResponse.self {
                data = self.trimUdacityResponse(data)
            }
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }

    func taskForGETRequest<ResponseType: Decodable>(
        url: URL, responseType: ResponseType.Type,
        completion: @escaping (ResponseType?, Error?) -> Void) {
        startLoading()
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            if responseType == UserResponse.self {
                data = self.trimUdacityResponse(data)
            }
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    func taskForDELETERequest<ResponseType: Decodable>(
        url: URL, responseType: ResponseType.Type,
        completion: @escaping (ResponseType?, Error?) -> Void) {
        startLoading()
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            if responseType == LogoutResponse.self {
                data = self.trimUdacityResponse(data)
            }
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}

