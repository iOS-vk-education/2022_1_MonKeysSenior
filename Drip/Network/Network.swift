//
//  Network.swift
//  Drip
//
//  Created by mikh.popov on 03.04.2022.
//

import Foundation

enum Constants {
    enum BackConstants: String {
        case BackURL = "https://drip.monkeys.team/api/v1/";
    }
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
        case responseCastError
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

typealias JSONObject = [String: Any]

func request<T: Decodable>(method: String, path: String, headers: Dictionary<String, String>, body: Data, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
    guard let url = URL(string: Constants.BackConstants.BackURL.rawValue + path) else {
        print("Error: cannot create URL")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    for (header, value) in headers {
        request.setValue(value, forHTTPHeaderField: header)
    }
    request.httpBody = body
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("request: error calling", method, path)
            print(error!)
            completion(Result.failure(Constants.APPError.networkError(error!)))
            return
        }
        guard let data = data else {
            print("request: did not receive data")
            completion(Result.failure(Constants.APPError.dataNotFound))
            return
        }
        guard let response = response as? HTTPURLResponse else {
            print("request: HTTP request failed")
            completion(Result.failure(Constants.APPError.responseCastError))
            return
        }
        guard (200 ..< 299) ~= response.statusCode else {
            print("request: invalid status code")
            completion(Result.failure(Constants.APPError.invalidStatusCode(response.statusCode)))
            return
        }
        do {
            let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
            completion(Result.success(decodedObject))
        } catch let error {
            completion(Result.failure(Constants.APPError.jsonParsingError(error as! DecodingError)))
            print("request: failed to convert JSON data to string")
            return
        }
    }.resume()
}

func loginRequest(credentials: Credentials, completion: @escaping (Result<User>) -> Void) {
    guard let jsonData = try? JSONEncoder().encode(credentials) else {
        print("loginRequest: convert model to JSON data failed")
        return
    }
    
    request(method: "POST", path: "session", headers: [:], body: jsonData, objectType: User.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}
