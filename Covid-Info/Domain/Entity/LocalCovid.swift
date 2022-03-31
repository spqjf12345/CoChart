//
//  LocalCovid.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/04/01.
//

import Foundation

struct LocalCovid: Codable {
    var resultCode: String
    var resultMessage: String
    var korea: LocalArea
    var seoul: LocalArea
    var busan: LocalArea
    var daegu: LocalArea
    var incheon: LocalArea
    var gwangju: LocalArea
    var daejeon: LocalArea
    var ulsan: LocalArea
    var sejong: LocalArea
    var gyeonggi: LocalArea
    var gangwon: LocalArea
    var chungbuk: LocalArea
    var chungnam: LocalArea
    var jeonbuk: LocalArea
    var jeonnam: LocalArea
    var gyeongbuk: LocalArea
    var gyeongnam: LocalArea
    var jeju: LocalArea
    var quarantine: LocalArea
}

struct LocalArea: Codable {
    var countryName: String
    var newCase: String
    var totalCase: String
    var recovered: String
    var death: String
    var percentage: String
    var newCcase: String
    var newFcase: String
}
