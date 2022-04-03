//
//  Encodable.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}

extension String{
    // remove amp; from string
func removeAMPSemicolon() -> String{
    return replacingOccurrences(of: "amp;", with: "")
}

// replace "&" with "And" from string
func replaceAnd() -> String{
    return replacingOccurrences(of: "&", with: "And")
}

// replace "\n" with "" from string
func removeNewLine() -> String{
    return replacingOccurrences(of: "\n", with: "")
}

func replaceAposWithApos() -> String{
    return replacingOccurrences(of: "Andapos;", with: "'")
}
}
