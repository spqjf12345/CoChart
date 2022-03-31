//
//  CovidAPI.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation


enum CovidAPI: NetworkRequest {
    case getInfo(CovidRequest)
    case getTotalInfo
}

extension CovidAPI {
    var baseURL: URL? {
        switch self {
        case .getInfo(let request):
                    return URL(string: "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(request.serviceKey)&pageNo=\(request.pageNo)&numOfRows=\(request.numOfRows)&startCreateDt=\(request.startCreateDt)&endCreateDt=\(request.endCreateDt)")
        case .getTotalInfo:
            return URL(string: Config.url)
        }
    }
    
    var path: String? {
        switch self {
        case .getInfo:
            return nil
        case .getTotalInfo:
            return nil
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .getInfo:
            return nil
        case .getTotalInfo:
            return ["serviceKey" : Config.serviceKey]
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getInfo, .getTotalInfo:
            return .get
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .getInfo, .getTotalInfo:
            return nil
        }
    }
    
    
    var headers: [String : Any]? {
        switch self {
        case .getInfo, .getTotalInfo:
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
