//
//  NetworkRequest.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation

protocol NetworkRequest {
    var baseURL: URL? { get }
    var requestURL: URL? { get }
    var path: String? { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    var headers: [String:Any]? { get }
    var body: [String: Any]? { get }
    var binary: Data? { get }
    var urlRequest: URLRequest? { get }
}
extension NetworkRequest {
    var requestURL: URL? {
        guard let path = path else { return baseURL }
        return baseURL?.appendingPathComponent(path, isDirectory: false)
    }
    
    var urlRequest: URLRequest? {
        guard let requestURL = requestURL else {
            return nil
        }
        
        var urlRequest: URLRequest
        
        var component = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
        
        var parameter = [URLQueryItem]()
        if let parameters = self.parameters {
            for (name, value) in parameters {
                if name.isEmpty { continue }
                parameter.append(URLQueryItem(name: name, value: value as? String))
            }
            if !parameter.isEmpty {
                component?.queryItems = parameter
            }
        }
        
        if let compoentURL = component?.url {
            urlRequest =  URLRequest(url: compoentURL)
        } else {
            urlRequest =  URLRequest(url: requestURL)
        }

        switch method {
        case .get:
            return urlRequest

        case .post, .put, .delete, .patch:
            urlRequest.httpMethod = method.rawValue
            
            if let httpbody = self.body {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: httpbody)
            } else if let binaryData = self.binary {
                urlRequest.httpBody = binaryData
            }

            headers?.forEach { key, value in
                urlRequest.addValue(value as! String, forHTTPHeaderField: key)
            }
            
            return urlRequest
        }
    }
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
