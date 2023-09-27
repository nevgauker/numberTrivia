//
//  NumberTriviaLocalDataSource.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 22/09/2023.
//

import Foundation

protocol NumberTriviaLocalDataSource {
    /// Gets the cached [NumberTriviaModel] which was gotten the last time
    /// the user had an internet connection.
    ///
    /// Throws [NoLocalDataException] if no cached data is present.
    func getLastNumberTrivia(completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void)
    
    func cacheNumberTrivia(triviaToCache:NumberTriviaModel,completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void)
}


class NumberTriviaLocalDataSourceImpl : NumberTriviaLocalDataSource{
    
    let NumberKey = "number"
    let TextKey = "text"
    let standard = Foundation.UserDefaults.standard
    
    func getLastNumberTrivia(completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void){
        let text = standard.string(forKey: TextKey)
        if text == nil {
            completion(.left(.CacheException))
            return
        }
        let number = standard.integer(forKey: NumberKey)
        let obj = NumberTriviaModel(text: text!, number: number)
        completion(.right(obj))
    }
    
    func cacheNumberTrivia(triviaToCache:NumberTriviaModel,completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void){
        standard.set(triviaToCache.number, forKey: NumberKey)
        standard.set(triviaToCache.text, forKey: TextKey)
        completion(.right(triviaToCache))

    }
}
