//
//  CovidUseCase.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

class CovidUseCase: CovidRepositoryProtocol {
    private let covidRepository: CovidRepositoryProtocol
    
    init(covidRepository: CovidRepositoryProtocol){
        self.covidRepository = covidRepository
    }
    
    func getCovid(request: CovidRequest) -> AnyPublisher<CovidResponse, NetworkError> {
        return covidRepository.getCovid(request: request)
    }
    
    func getTotalCovid() -> AnyPublisher<TotalCovid, NetworkError> {
        return covidRepository.getTotalCovid()
    }
    
    func getLocalCovid() -> AnyPublisher<LocalCovid, NetworkError> {
        return covidRepository.getLocalCovid()
    }
    
    
    
    
}
