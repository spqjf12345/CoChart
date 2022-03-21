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
        let publisher: AnyPublisher<CovidResponse, NetworkError> = self.networkRequest.request(request)
        return publisher
    }
}
