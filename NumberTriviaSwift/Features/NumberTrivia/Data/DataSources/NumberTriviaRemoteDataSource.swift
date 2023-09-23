//
//  NumberTriviaRemoteDataSource.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 22/09/2023.
//
//
import Foundation

protocol NumberTriviaRemoteDataSource {
    /// Calls the http://numbersapi.com/{number} endpoint.
    ///
    /// Throws a [ServerException] for all error codes.
     func getConcreteNumberTrivia (number:Int) async throws->NumberTriviaModel
    /// Calls the http://numbersapi.com/random endpoint.
    ///
    /// Throws a [ServerException] for all error codes.
    func  getRandomNumberTrivia() async throws-> NumberTriviaModel
}
