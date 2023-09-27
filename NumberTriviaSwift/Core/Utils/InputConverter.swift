//
//  InputConverter.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 25/09/2023.
//

import Foundation

class InputConverter {
    class func stringToUnsignedInteger(numStr:String)-> Either<Failure,Int>{
        
        let mySet = CharacterSet(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
        let valid = numStr.rangeOfCharacter(from: mySet) != nil
        if (!valid) { return .left(.noPositiveNumber)}
        if let someInt = Int(numStr) {
            if someInt >= 0 {
                return .right(someInt)
            }
        }
        return .left(.noPositiveNumber)
    }

}
