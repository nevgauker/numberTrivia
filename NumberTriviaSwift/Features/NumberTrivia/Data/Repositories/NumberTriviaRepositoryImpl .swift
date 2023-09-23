//
//  NumberTriviaRepositoryImpl .swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 22/09/2023.
//

import Foundation


class NumberTriviaRepositoryImpl : NumberTriviaRepository {

  final let  remoteDataSource: NumberTriviaRemoteDataSource
  final let localDataSource: NumberTriviaLocalDataSource
  final let networkInfo: NetworkInfo
    
    
      init(remoteDataSource:NumberTriviaRemoteDataSource, localDataSource: NumberTriviaLocalDataSource,networkInfo: NetworkInfo){
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.networkInfo = networkInfo
    }
    
    
    func getConcreteNumberTrivia(params: Params?, completion: @escaping (Either<Failure, NumberTrivia>) -> Void) async {
        
        if let number = params?.number {

            if networkInfo.isConnected {
                //network
                if let result =  try? await remoteDataSource.getConcreteNumberTrivia(number: number){
                    
                    let obj =  NumberTrivia(text: result.text, number: result.number)

                    completion(.right(obj))
                } else{
                    completion(.left(.someError))
                }

            }else{
                //local
                if let result =  try? await localDataSource.getLastNumberTrivia(){
                    
                    let obj =  NumberTrivia(text: result.text, number: result.number)
                    completion(.right(obj))
                    completion(.left(.someError))
                }
            }
        }
        else{
            completion(.left(.missingParams))
        }
    }
    
    func getRandomNumberTrivia(completion: @escaping (Either<Failure, NumberTrivia>) -> Void) {
        
    }
    
    
    
}
