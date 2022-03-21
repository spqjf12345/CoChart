//
//  Requestable.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Combine

public protocol Requestable {
    var requestTimeout: Float { get }
    
    func request<T: Codable> (_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
