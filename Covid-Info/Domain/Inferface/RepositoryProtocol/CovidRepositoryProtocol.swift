//
//  CovidRepositoryProtocol.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

protocol CovidRepositoryProtocol {
    func getCovid(request: CovidRequest) -> AnyPublisher<CovidResponse, NetworkError>
    func getTotalCovid() -> AnyPublisher<TotalCovid, NetworkError>
    func getLocalCovid() -> AnyPublisher<LocalCovid, NetworkError>
}
