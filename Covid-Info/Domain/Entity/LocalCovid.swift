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
    
    static var localArea = LocalArea(countryName: "", death: "", newCase: "", newFcase: "", percentage: "", recovered: "", totalCase: "")
    static var EMPTY = LocalCovid(resultCode: "", resultMessage: "", korea: localArea, seoul: localArea, busan: localArea, daegu: localArea, incheon: localArea, gwangju: localArea, daejeon: localArea, ulsan: localArea, sejong: localArea, gyeonggi: localArea, gangwon: localArea, chungbuk: localArea, chungnam: localArea, jeonbuk: localArea, jeonnam: localArea, gyeongbuk: localArea, gyeongnam: localArea, jeju: localArea, quarantine: localArea)
}

struct LocalArea: Codable {
    var countryName: String
    var death: String
    var newCase: String
    var newFcase: String
    var percentage: String
    var recovered: String
    var totalCase: String
}

struct DetailLocalCovid: Identifiable {
    let id = UUID()
    let name: String
    
    let icon: String
    var items: [DetailLocalCovid]?
    

    static let seoul = DetailLocalCovid(name: "서울", icon: "1.circle")
    static let busan = DetailLocalCovid(name: "부산", icon: "1.circle")
    static let daegu = DetailLocalCovid(name: "대구", icon: "1.circle")
    static let incheon = DetailLocalCovid(name: "인천", icon: "1.circle")
    static let gwangju = DetailLocalCovid(name: "광주", icon: "1.circle")
    static let daejeon = DetailLocalCovid(name: "대전", icon: "1.circle")
    static let ulsan = DetailLocalCovid(name: "울산", icon: "1.circle")
    static let sejong = DetailLocalCovid(name: "세종", icon: "1.circle")
    static let gyeonggi = DetailLocalCovid(name: "경기", icon: "1.circle")
    static let gangwon = DetailLocalCovid(name: "강원", icon: "1.circle")
    static let chungbuk = DetailLocalCovid(name: "충북", icon: "1.circle")
    static let chungnam = DetailLocalCovid(name: "충남", icon: "1.circle")
    static let jeonbuk = DetailLocalCovid(name: "전북", icon: "1.circle")
    static let jeonnam = DetailLocalCovid(name: "전남", icon: "1.circle")
    static let gyeongbuk = DetailLocalCovid(name: "경북", icon: "1.circle")
    static let gyeongnam = DetailLocalCovid(name: "경남", icon: "1.circle")
    static let jeju = DetailLocalCovid(name: "제주", icon: "1.circle")
    
}
