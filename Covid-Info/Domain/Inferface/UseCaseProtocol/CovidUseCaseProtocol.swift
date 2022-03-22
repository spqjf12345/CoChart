//
//  CovidUseCaseProtocol.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

protocol CovidUseCaseProtocol {
    func getCovidData(for request: CovidRequest) -> AnyPublisher<CovidResponse, NetworkError>
}
