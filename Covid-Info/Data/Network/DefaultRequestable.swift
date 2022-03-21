//
//  DefaultRequestable.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

public class DefaultRequestable: Requestable {
    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeout)
        
        guard let url = URL(string: req.url) else {
            return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.badURL("Invalid URL")))
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
         NetworkError.invalidJSON(String(describing: error))
     }
     .eraseToAnyPublisher()
        
        
    }
    
    public var requestTimeout: Float = 30
    
    
    
    
}
