//
//  DefaultRequestable.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

final class DefaultRequestable: Requestable {
    
    
    static let shared: DefaultRequestable = DefaultRequestable()
    
    private let decoder: JSONDecoder = JSONDecoder()
    
    func request(_ req: NetworkRequest) -> AnyPublisher<Data, NetworkError> {
        guard let urlRequest = req.urlRequest else {  return AnyPublisher(Fail<Data, NetworkError>(error: NetworkError.badURL("Invalid URL"))) }
        print(urlRequest)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    switch (response as? HTTPURLResponse)?.statusCode {
                    case .some(404):
                        throw NetworkError.badRequest(code: 404, error: "bad request")
                    default:
                        throw NetworkError.serverError(code: 500, error: "server error")
                    }
                }
                return data
            }
            .mapError { error in
                return NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> {
        return request(req)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    print("url error")
                case is DecodingError:
                    print("decoding error")
                default:
                    print("noting")
                }
                return NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
