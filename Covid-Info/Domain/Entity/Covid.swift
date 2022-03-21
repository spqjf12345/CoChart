//
//  Covid.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Foundation

struct CovidRequest : Codable {
    var ServiceKey: String
    var pageNo: Int
    var numOfRows: Int
    var startCreateDt: String
    var endCreateDt: String
}

struct CovidResponse: Codable {
    var items: [Item]
    var numOfRows: Int
    var pageNo: Int
    var totalCount: Int
}

struct Item: Codable {
    var accDefRate: Double
    var accExamCnt: Int
    var createDt: String
    var deathCnt: Int
    var decideCnt: Int
    var seq: Int
    var stateDt: String
    var stateTime: String
    var updateDt: String
}
