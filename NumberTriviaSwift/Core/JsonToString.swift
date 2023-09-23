//
//  JsonToString.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation


enum JsonFailure: Error {
    case errorConverting
    case notFound
}

class JsonToString {
    static let BASE  = "Fixtures/"
    class func jsonToString(filename:String,ext:String) async  -> Either<JsonFailure,String>{
        let jsonFileURL = Bundle.main.url(forResource: filename, withExtension:ext)
        if let jsonFileURL = jsonFileURL {
            do {
                // Read JSON data from the file
                let jsonData = try Data(contentsOf: jsonFileURL)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    // Print or use the JSON string
                    return(.right(jsonString))
                } else {
                    return(.left(.errorConverting))
                }
            } catch {
                print(error)
                return(.left(.errorConverting))

            }
        } else {
            return(.left(.notFound))
        }
    }
}
