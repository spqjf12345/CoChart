//
//  TotalCovid.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/31.
//

import Foundation

struct ToTalCovidRequest: Codable {
    var resultCode: String
    var TotalCase: String
    var TotalRecovered: String
    var TotalDeath: String
    var NowCase: String
    var city1n: String
    var city2n: String
    var city3n: String
    var city4n: String
    var city5n: String
    var city1p: String
    var city2p: String
    var city3p: String
    var city4p: String
    var city5p: String
    var recoveredPercentage: Double
    var deathPercentage: Double
    var checkingCounter: Double
    var checkingPercentage: Double
    var caseCount: Double
    var casePercentage: Double
    var notcaseCount: Double
    var notcasePercentage: Double
    var TotalChecking: Double
    var TodayRecovered: Double
    var TodayDeath: Double
    var TotalCaseBefore: String
    var source: String
    var updateTime: String
    var resultMessage: String
}

