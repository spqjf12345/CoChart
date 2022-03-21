//
//  Covid.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Foundation

struct CovidRequest : Codable {
    var serviceKey: String
    var pageNo: String
    var numOfRows: String
    var startCreateDt: String
    var endCreateDt: String
}

struct CovidResponse: Codable {
    var response: CovidRes
}

struct CovidRes: Codable {
    var header: CovidResponseHeader
    var body: CovidResponseBody
}


struct CovidResponseHeader: Codable {
    var resultCode: String
    var resultMsg: String
}

struct CovidResponseBody: Codable {
    var items: Item
    var numOfRows: String
    var pageNo: String
    var totalCount: String
}

struct Item: Codable {
    var item: [ItemResponse]
}

struct ItemResponse: Codable {
    var accDefRate: String
    var accExamCnt: String
    var createDt: String
    var deathCnt: String
    var decideCnt: String
    var seq: String
    var stateDt: String
    var stateTime: String
    var updateDt: String
}

