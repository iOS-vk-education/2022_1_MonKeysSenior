import UIKit

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
    case success(T?)
    case failure(Error)
}

typealias JSONObject = [String: Any]

func request<T: Codable>(method: String, path: String, headers: Dictionary<String, String>, body: Data?, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
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
    if body != nil {
        request.httpBody = body
    }
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
        
        if let fields = response.allHeaderFields as? [String:String] {
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
            
            if let cookie = cookies.first {
                var cookieProperties: [HTTPCookiePropertyKey: Any] = [:]
                cookieProperties[.name] = cookie.name
                cookieProperties[.value] = cookie.value
                cookieProperties[.domain] = cookie.domain
                
                if let myCookie = HTTPCookie(properties: cookieProperties) {
                    HTTPCookieStorage.shared.setCookie(myCookie)
                }
            }
        }
        
        guard (200 ..< 299) ~= response.statusCode else {
            print("request: invalid status code")
            completion(Result.failure(Constants.APPError.invalidStatusCode(response.statusCode)))
            return
        }
        do {
//            print(response.)
            
            let decodedResponse = try JSONDecoder().decode(Response<T>.self, from: data)
            print(decodedResponse)
            if decodedResponse.status == 200 {
                completion(Result.success(decodedResponse.body))
            } else {
                print("request: invalid status response status")
                completion(Result.failure(Constants.APPError.invalidStatusCode(response.statusCode)))
                return
            }
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
    
    request(method: "POST", path: "auth/session", headers: [:], body: jsonData, objectType: User.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func logoutRequest(completion: @escaping (Result<User>) -> Void) {
    request(method: "DELETE", path: "session", headers: [:], body: nil, objectType: User.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func signupRequest(credentials: Credentials, completion: @escaping (Result<User>) -> Void) {
    guard let jsonData = try? JSONEncoder().encode(credentials) else {
        print("signupRequest: convert model to JSON data failed")
        return
    }
    
    request(method: "POST", path: "auth/profile", headers: [:], body: jsonData, objectType: User.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func getProfileRequest(completion: @escaping (Result<User>) -> Void) {
    request(method: "GET", path: "auth/profile", headers: [:], body: nil, objectType: User.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func updateProfileRequest(userInfo: User, completion: @escaping (Result<User>) -> Void) {
    guard let jsonData = try? JSONEncoder().encode(userInfo) else {
        print("loginRequest: convert model to JSON data failed")
        return
    }
    
    request(method: "PUT", path: "profile", headers: [:], body: jsonData, objectType: User.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func feedRequest(completion: @escaping (Result<Users>) -> Void) {
    request(method: "GET", path: "user/cards", headers: [:], body: nil, objectType: Users.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

// TODO: what is in response body?
func reactionRequest(reaction: Reaction, completion: @escaping (Result<Array<User>>) -> Void) {
    guard let jsonData = try? JSONEncoder().encode(reaction) else {
        print("loginRequest: convert model to JSON data failed")
        return
    }

    request(method: "POST", path: "likes", headers: [:], body: jsonData, objectType: Array<User>.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func matchesRequest(completion: @escaping (Result<Array<User>>) -> Void) {
    request(method: "GET", path: "match", headers: [:], body: nil, objectType: Array<User>.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

func matchesRequest(search: Search, completion: @escaping (Result<Array<User>>) -> Void) {
    guard let jsonData = try? JSONEncoder().encode(search) else {
        print("loginRequest: convert model to JSON data failed")
        return
    }

    request(method: "POST", path: "match", headers: [:], body: jsonData, objectType: Array<User>.self) { (result: Result) in
        switch result {
        case .success(let object):
            completion(Result.success(object))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

// TODO: tag request 'GET' 'tags'

// TODO: tag request 'POST' 'profile/photo'

// TODO: tag request 'DELETE' 'profile/photo'

// TODO: tag request 'GET' 'chats'

// TODO: tag request 'GET' 'chat'

// TODO: tag request 'POST' 'chat'
