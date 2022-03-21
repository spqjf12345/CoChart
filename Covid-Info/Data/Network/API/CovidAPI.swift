//
//  CovidAPI.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation
import Moya

enum CovidAPI {
    case getInfo(covidRequest: Covid)
}

extension CovidAPI: TargetType {
    var baseURL: URL {
        return URL(string: Config.url)!
    }
    
    var path: String {
        switch self {
        case .getInfo:
            return "/service/rest/Covid19"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getInfo(let covidRequest):
            return .requestParameters(parameters: covidRequest.dictionary, encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
