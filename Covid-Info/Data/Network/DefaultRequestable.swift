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
    
//    func requestXML<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
//
//        request(req).sink { (completion) in
//            switch completion {
//            case .failure(let error):
//                print("opps \(error)")
//            case .finished:
//                print("nothing much to do here")
//            }
//        } receiveValue : { response in
//            guard let xmlString = String(data: data!, encoding: .utf8) else { return }
//            let xmlParser = ParseXMLData(xml: xmlString)
//            let jsonString = parser.parseXML()
//
//            let data: Data? = jsonString.data(using: .utf8)
//            let json = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
//             print(json ?? "Empty Data")
//            let d = try JSONDecoder().decode(CovidResponse.self, from: data!)
//        }
//
//    }
    
    
    
    
}
