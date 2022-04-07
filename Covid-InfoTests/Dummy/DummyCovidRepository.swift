//
//  DummyCovidRepository.swift
//  Covid-InfoTests
//
//  Created by JoSoJeong on 2022/04/07.
//

import Foundation
import Combine

@testable import Covid_Info

class DummyCovidRepository: CovidRepositoryProtocol {
    var isSuccessMode: Bool = true
    
    init(isSuccessMode: Bool) {
        self.isSuccessMode = isSuccessMode
    }
    
    var request: CovidRequest = CovidRequest(serviceKey: Config.baseServiceKey, pageNo: "1", numOfRows: "1", startCreateDt: "20201001", endCreateDt: "20201030")
    
    func getCovid(request: CovidRequest) -> AnyPublisher<CovidResponse, NetworkError> {
        if self.isSuccessMode {
            return Just(CovidResponse.EMPTY).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NetworkError.noResponse("No Response")).eraseToAnyPublisher()
        }
        
    }
    
    func getTotalCovid() -> AnyPublisher<TotalCovid, NetworkError> {
        if self.isSuccessMode {
            return Just(TotalCovid.EMPTY).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NetworkError.noResponse("No Response")).eraseToAnyPublisher()
        }
    }
    
    func getLocalCovid() -> AnyPublisher<LocalCovid, NetworkError> {
        if self.isSuccessMode {
            return Just(LocalCovid.EMPTY).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NetworkError.noResponse("No Response")).eraseToAnyPublisher()
        }
    }
    
    
}
