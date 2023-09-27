//
//  APICaller.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 26/09/2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    let getConcreteNumberTrivia = GetConcreteNumberTrivia()
    let getRandomNumberTrivia = GetRandomNumberTrivia()
    
    func fetchNumberTrivia(num:Int?, completion: @escaping (Either<Failure, NumberTrivia>) -> Void){
        if let  number = num {
            getConcreteNumberTrivia.call(params: Params(number: number), completion: {
                result in
               completion(result)
            })
        }else{
            getRandomNumberTrivia.call(params: nil, completion: {
                result in
                completion(result)
            })
        }
    }
}
