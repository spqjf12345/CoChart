//
//  Requestable.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

protocol Requestable {
    func request(_ req: NetworkRequest) -> AnyPublisher<Data, NetworkError>
    func request<T: Codable> (_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
