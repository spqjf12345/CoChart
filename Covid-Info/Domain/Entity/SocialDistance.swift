//
//  SocialDistance.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/23.
//

import Foundation

struct SocialDistance: Codable {
    var updateDate: String
    var dueDate: [String]
    var summary: [Summary]
    var category: [Category]
}

struct Summary: Codable {
    var title: String
    var detail: [String]
}

struct Category: Codable, Identifiable {
    var id: Int
    var place: [String]
    var operatingTime: String
    var isEat: String
    var other: String
}
