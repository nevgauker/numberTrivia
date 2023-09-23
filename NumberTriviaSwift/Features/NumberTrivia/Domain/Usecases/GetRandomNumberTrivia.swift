////
////  GetRandomNumberTrivia.swift
////  NumberTriviaSwift
////
////  Created by Rotem Nevgauker on 21/09/2023.
////
//
////
////  GetConcreteNumberTrivia.swift
////  NumberTriviaSwift
////
////  Created by Rotem Nevgauker on 21/09/2023.
////
//
import Foundation

class GetRandomNumberTrivia: UseCase {
  
  
    typealias theType = NumberTrivia
    typealias params = Params
    
    let repository = MockNumberTriviaRepository()
    
    func call(params: params?, completion: @escaping (Either<Failure, theType>) -> Void) {
        return  repository.getRandomNumberTrivia( completion: { result in
            
        });
        
    }
    
}

