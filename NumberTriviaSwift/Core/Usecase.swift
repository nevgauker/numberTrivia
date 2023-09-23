//
//  Usecase.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation

protocol UseCase {
    associatedtype TheType
    associatedtype Params
    
     func call(params: Params?, completion: @escaping (Either<Failure, TheType>) -> Void)

}

class NoParams: Equatable {
    static func == (lhs: NoParams, rhs: NoParams) -> Bool {
    return  lhs === rhs
    }
}
