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
     func getConcreteNumberTrivia (number:Int,completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void)
    /// Calls the http://numbersapi.com/random endpoint.
    ///
    /// Throws a [ServerException] for all error codes.
    func  getRandomNumberTrivia(completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void)
}

class NumberTriviaRemoteDataSourceImpl : NumberTriviaRemoteDataSource{
    func getRandomNumberTrivia(completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void) {
        let urlStr = "http://numbersapi.com/random?json"
        if let url = URL(string:urlStr) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) {  (data, response, error) in
                if error == nil {
                    if   let data = data {
                        
                        do {
                            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                // Now, jsonDict contains the JSON data as a [String: Any] dictionary
                                print(jsonDict)
                                let obj = NumberTriviaModel.fromJson(json: jsonDict)
                                if let returnedObject = obj {
                                    completion(.right(returnedObject))
                                }else{
                                    completion(.left(ServerException.ServerException))
                                }
                            }
                        } catch {
                            completion(.left(ServerException.JSONSerializationException))
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func getConcreteNumberTrivia(number: Int, completion: @escaping (Either<ServerException, NumberTriviaModel>) -> Void) {
        let urlStr = "http://numbersapi.com/" + String(number) + "?json"
        if let url = URL(string:urlStr) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) {  (data, response, error) in
                if error == nil {
                    if   let data = data {
                        
                        do {
                            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                // Now, jsonDict contains the JSON data as a [String: Any] dictionary
                                print(jsonDict)
                                let obj = NumberTriviaModel.fromJson(json: jsonDict)
                                if let returnedObject = obj {
                                    completion(.right(returnedObject))
                                }else{
                                    completion(.left(ServerException.ServerException))
                                }
                            }
                        } catch {
                            completion(.left(ServerException.JSONSerializationException))
                        }
                    }
                }
            }
            task.resume()
        }
        
    }

}





