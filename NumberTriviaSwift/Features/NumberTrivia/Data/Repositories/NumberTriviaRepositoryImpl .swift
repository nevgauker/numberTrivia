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
    
    
    func getConcreteNumberTrivia(params: Params?, completion: @escaping (Either<Failure, NumberTrivia>) -> Void)  {
        
        if let number = params?.number {

            if networkInfo.isConnected {
                //network
                
                remoteDataSource.getConcreteNumberTrivia(number: number){ result in
                    switch result {
                    case .left(let serverExecption):
                        print(serverExecption)
                        completion(.left(.someError))
                    case .right(let numberTrivia):
                        self.self.localDataSource.cacheNumberTrivia(triviaToCache: numberTrivia, completion: {
                            _ in
                        })
                        let obj =  NumberTrivia(text: numberTrivia.text, number: numberTrivia.number)
                        completion(.right(obj))
                    }
                }
            }else{
                //local
                localDataSource.getLastNumberTrivia(){ result in
                    switch result {
                    case .left(_ ):
                        completion(.left(.someError))
                    case .right(let numberTrivia):
                        self.self.localDataSource.cacheNumberTrivia(triviaToCache: numberTrivia, completion: {
                            _ in
                        })
                        let obj =  NumberTrivia(text: numberTrivia.text, number: numberTrivia.number)
                        completion(.right(obj))
                    }
                }
            }
        }
        else{
            completion(.left(.missingParams))
        }
    }
    
    func getRandomNumberTrivia(completion: @escaping (Either<Failure, NumberTrivia>) -> Void) {
        if networkInfo.isConnected {
            //network
            
            remoteDataSource.getRandomNumberTrivia(){result in
                    switch result {
                    case .right(let number):
                        let obj =  NumberTrivia(text: number.text, number: number.number)
                        completion(.right(obj))
                    case .left(let err):
                        print(err)
                        completion(.left(.someError))
                    }
            }
        }else{
            //local
          localDataSource.getLastNumberTrivia(){ result in
              switch result {
              case .left(_ ):
                  completion(.left(.someError))
              case .right(let numberTrivia):
                  let obj =  NumberTrivia(text: numberTrivia.text, number: numberTrivia.number)
                  completion(.right(obj))
              }
            }
        }
    }
    
    
    
}
