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
            return URL(string: "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(request.serviceKey)&pageNo=\(request.pageNo)&numOfRows=\(request.numOfRows)&startCreateDt=\(request.startCreateDt)&endCreateDt=\(request.endCreateDt)")
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

//extension CovidAPI: TargetType {
//    var baseURL: URL {
//        return URL(string: Config.url)!
//    }
//
//    var path: String {
//        switch self {
//        case .getInfo:
//            return "/service/rest/Covid19"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .getInfo:
//            return .get
//        }
//    }
//
//    var task: Task {
//        switch self {
//        case .getInfo(let covidRequest):
//            return .requestParameters(parameters: covidRequest.dictionary, encoding: JSONEncoding.default)
//        }
//
//    }
//
//    var headers: [String : String]? {
//        return nil
//    }
//
//
//}
