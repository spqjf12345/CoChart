//
//  TotalCovid.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/31.
//

import Foundation

struct TotalCovid: Codable {
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
    
    static var EMPTY = TotalCovid(resultCode: "", TotalCase: "", TotalRecovered: "", TotalDeath: "", NowCase: "", city1n: "city1n", city2n: "city2n", city3n: "city3n", city4n: "city4n", city5n: "city5n", city1p: "0", city2p: "0", city3p: "0", city4p: "0", city5p: "0", recoveredPercentage: 0, deathPercentage: 0, checkingCounter: 0, checkingPercentage: 0, caseCount: 0, casePercentage: 0, notcaseCount: 0, notcasePercentage: 0, TotalChecking: 0, TodayRecovered: 0, TodayDeath: 0, TotalCaseBefore: "", source: "", updateTime: "", resultMessage: "")
}

