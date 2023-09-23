//
//  MockNumberTriviaRepository.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation


class MockNumberTriviaRepository: NumberTriviaRepository {
    
    let isConnected = true
    func getConcreteNumberTrivia(params: Params?, completion: @escaping (Either<Failure, NumberTrivia>) -> Void) {
        guard let p = params  else {  return completion(.left(Failure.missingParams))}
        
        // Simulate a successful response with some test data
        if (isConnected){
            let trivia = NumberTrivia(text: "Test trivia", number: p.number)
            completion(.right(trivia))
        }else{
            let trivia = NumberTrivia(text: "Test trivia local", number: p.number)
            completion(.right(trivia))
        }
    }
    
    func getRandomNumberTrivia(completion: @escaping (Either<Failure, NumberTrivia>) -> Void) {
        // Simulate a successful response with some test data
        let trivia = NumberTrivia(text: "Random trivia", number: 42)
        completion(.right(trivia))
    }
    
}
