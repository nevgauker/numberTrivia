//
//  Either.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

//class NumberTriviaRes:Equatable{
// 
//    let text: String
//    let number: Int
//    init(text:String,number:Int){
//        self.number = number
//        self.text = text
//    }
//    static func == (lhs: NumberTriviaRes, rhs: NumberTriviaRes) -> Bool {
//        return (lhs.number == rhs.number && lhs.text == rhs.text)
//    }
//}

enum Failure: Error {
    case someError
    case missingParams
}
