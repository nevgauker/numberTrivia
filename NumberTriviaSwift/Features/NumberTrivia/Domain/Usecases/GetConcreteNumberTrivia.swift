////
////  GetConcreteNumberTrivia.swift
////  NumberTriviaSwift
////
////  Created by Rotem Nevgauker on 21/09/2023.
////
//
import Foundation

class Params: Equatable {

    let number:Int
    init(number:Int){
        self.number = number
    }

    static func == (lhs: Params, rhs: Params) -> Bool {
        return lhs.number == rhs.number
    }

}

class GetConcreteNumberTrivia: UseCase {
    typealias theType = NumberTrivia
    typealias params = Params

    //let repository = MockNumberTriviaRepository()
    
    
    let repository = NumberTriviaRepositoryImpl(remoteDataSource: NumberTriviaRemoteDataSourceImpl(), localDataSource: NumberTriviaLocalDataSourceImpl(), networkInfo: NetworkInfoImpl())

    func call(params: params?, completion: @escaping (Either<Failure, theType>) -> Void)  {
        return   repository.getConcreteNumberTrivia(params: params! , completion: { result in
            completion(result)
        });

    }

}

