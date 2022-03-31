//
//  CovidRepository.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

class CovidRepository: CovidRepositoryProtocol {
    private var networkRequest: Requestable
    
    init(networkRequest: DefaultRequestable){
        self.networkRequest = networkRequest
    }
    
    func getCovid(request: CovidRequest) -> AnyPublisher<CovidResponse, NetworkError> {
        let request = CovidAPI.getInfo(request)
        let publisher: AnyPublisher<Data, NetworkError> = self.networkRequest.request(request)
        let response = publisher.map { data in
                let xmlString = String(data: data, encoding: .utf8)!
                let parser = ParseXMLData(xml: xmlString)
            return parser.parseXML().data(using: .utf8)!
            }
        .decode(type: CovidResponse.self, decoder: JSONDecoder())
        .mapError { error in
            return NetworkError.invalidJSON(String(describing: error))
        }.eraseToAnyPublisher()
        return response
    }
    
    func getTotalCovid() -> AnyPublisher<TotalCovid, NetworkError> {
        let request = CovidAPI.getTotalInfo
        return self.networkRequest.request(request)
        .decode(type: TotalCovid.self, decoder: JSONDecoder())
        .mapError { error in
            return NetworkError.invalidJSON(String(describing: error))
        }.eraseToAnyPublisher()
    }
    
}
