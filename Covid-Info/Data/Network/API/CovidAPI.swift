//
//  CovidAPI.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation


enum CovidAPI: NetworkRequest {
    case getInfo(CovidRequest)
}

extension CovidAPI {
    var baseURL: URL? {
        switch self {
        case .getInfo(let request):
            return URL(string: Config.url)
        }
    }
    
    var path: String? {
        switch self {
        case .getInfo(let request):
            return nil
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .getInfo(let request):
            return nil
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getInfo:
            return .get
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .getInfo:
            return nil
        }
    }
    
    
    var headers: [String : Any]? {
        switch self {
        case .getInfo:
            return nil
        }
    }
    
    var binary: Data? {
        switch self {
        default:
            return nil
        }
    }
    
}
