//
//  ApiClient.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation
import UIKit

public struct Request {
    public let method: HTTPMethod
    public let root: String
    public let parameters: URLParameters?
    public let body: Any?
    
    var url: URL? {
        guard let escaped = root.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }

        guard let parameters = parameters else {
            return URL(string: escaped)
        }

        guard let url = URL(string: escaped), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        let queryItems: [URLQueryItem] = parameters.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }

        components.queryItems = queryItems
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }

        guard method != .GET else {
            return URLRequest(url: url)
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if let body = body {
                let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = bodyData
            }
            return request
        } catch {
            return nil
        }
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}


public enum APIError: Error {
    case connection(Error)
    case invalidEndPoint
    case invalidResponse
}


public typealias CompletionHandler<T: Codable> = Result<T, APIError>
public typealias URLParameters = [String : String]
public typealias HTTPHeader = [AnyHashable : Any]


public class ApiClient {

    lazy var urlSession: URLSession = {
        return URLSession(configuration: self.configuration)
    }()

    lazy var configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = self.defaultHeaders
        return config
    }()
    
    public var defaultHeaders: HTTPHeader = ["Content-Type": "application/json; charset=utf-8"]

    public var loggingEnabled = true

    public var developmentModeEnabled = true

    fileprivate var currentTasks: Set<URLSessionDataTask> = []

    public init(configuration: URLSessionConfiguration?) {
        if let configuration = configuration {
            self.configuration = configuration
        }
    }
}

// MARK: - REST API

public extension ApiClient {
    
    // MARK: GET

    // GET Item
    @discardableResult
    func GET<T: Codable>(_ root: String, parameters: URLParameters? = nil, completion: @escaping (CompletionHandler<T>) -> Void) -> URLSessionDataTask? {
        let request = Request(method: .GET, root: root, parameters: parameters, body: nil)
        return self.request(request: request, completion: completion)
    }

    // GET Array
    @discardableResult
    func GET<T: Codable>(_ root: String, parameters: URLParameters? = nil, completion: @escaping (CompletionHandler<[T]>) -> Void) -> URLSessionDataTask? {
        let request = Request(method: .GET, root: root, parameters: parameters, body: nil)
        return self.request(request: request, completion: completion)
    }

    @discardableResult
    private func request<T: Codable>(request: Request, completion: @escaping (CompletionHandler<T>) -> Void) -> URLSessionDataTask? {
        
        guard var urlRequest = request.urlRequest else {
            return nil
        }
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        print("REQUEST CURL ==>", urlRequest.cURL(pretty: true))
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            print("RESPONSE ==>", response.debugDescription)
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.connection(error)))
                }
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            do {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {                 //For Debug Only
                    print("RESPONSE ==>", JSONString)
                }
                let value = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(value))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.connection(error)))
                }
            }
        }
        
        task.resume()
        return task
        
    }
}

// MARK: - Debug Logging

private extension ApiClient {

    func debugLog(msg: String) {
        guard loggingEnabled else { return }
        print(msg)
    }

    func debugResponseData(data: Data) {
        guard loggingEnabled else { return }
        if let body = String(data: data, encoding: String.Encoding.utf8) {
            print(body)
        } else {
            print("<empty response>")
        }
    }
}


extension URLRequest {
    
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
            
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
}
