//
//  NumberTriviaModel.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation

class NumberTriviaModel : NumberTrivia {

    override init(text:String,number:Int){
        super.init(text: text ,number: number)
    }

    static func fromJson(json: [String: Any]) -> NumberTriviaModel? {

        var num:Int? = nil
        num = json["number"] as? Int

        if let doubleValue = json["number"] as? Double {
            
            if doubleValue >= Double(Int.min) && doubleValue <= Double(Int.max) {
                let intValue = Int(doubleValue)
                num = intValue
            } else {
                print("Double value is too large to fit into an Int.")
            }
        }

        guard let text = json["text"] as? String, let number = num   else {
            return nil // Return nil if the required keys are not present in the JSON
        }

        return NumberTriviaModel(text: text, number: number)
    }

    static func toJson(obj:NumberTriviaModel) -> [String: Any] {
        let dict:[String: Any ] = ["number": obj.number, "text" : obj.text]
        return dict
    }

}
