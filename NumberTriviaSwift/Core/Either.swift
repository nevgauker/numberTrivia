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


enum Failure: Error {
    case someError
    case missingParams
    case noPositiveNumber
}
