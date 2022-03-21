//
//  Covid.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Foundation

struct Covid : Codable {
    var ServiceKey: String
    var pageNo: Int
    var numOfRows: Int
    var startCreateDt: String
    var endCreateDt: String
}
