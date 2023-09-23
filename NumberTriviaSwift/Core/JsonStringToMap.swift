//
//  JsonStrinngToMap.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation

enum JsonMapFailure: Error {
    case errorCasting
    case errorDecoding
    case errorConverting

}


class JsonStringToMap {
    class func jsonStringToMap(str:String) async  -> Either<JsonMapFailure,[String: Any]>{
        if let jsonData = str.data(using: .utf8) {
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return(.right(jsonObject))
                } else {
                    return(.left(.errorCasting))
                }
            } catch {
                return(.left(.errorDecoding))
            }
        } else {
            return(.left(.errorConverting))
        }
    }
}
