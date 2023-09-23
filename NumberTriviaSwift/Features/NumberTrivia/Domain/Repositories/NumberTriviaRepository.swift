//
//  NumberTriviaRepository.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation


protocol NumberTriviaRepository {
    func getConcreteNumberTrivia(params: Params?, completion: @escaping (Either<Failure, NumberTrivia>) -> Void) async
    func getRandomNumberTrivia(completion: @escaping (Either<Failure, NumberTrivia>) -> Void)
}
