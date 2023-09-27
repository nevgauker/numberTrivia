//
//  NumberTriviaRepositoryTests.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 23/09/2023.
//

import XCTest
@testable import NumberTriviaSwift

// Define mock classes conforming to their respective protocols
class Mock {}

class MockRemoteDataSource: Mock, NumberTriviaRemoteDataSource {
    func getConcreteNumberTrivia(number: Int, completion: @escaping (NumberTriviaSwift.Either<ServerException, NumberTriviaModel>) -> Void) {
        let fake = NumberTriviaModel(text: "remote number", number: 1)
        completion(.right(fake))
    }
    
    func getRandomNumberTrivia(completion: @escaping (NumberTriviaSwift.Either<ServerException, NumberTriviaModel>) -> Void) {
        let fake = NumberTriviaModel(text: "random number", number: 1)
        completion(.right(fake))

    }
}
class MockLocalDataSource: Mock, NumberTriviaLocalDataSource {
    func getLastNumberTrivia(completion: @escaping (NumberTriviaSwift.Either<ServerException, NumberTriviaModel>) -> Void) {
        let fake = NumberTriviaModel(text: "local number", number: 1)
        completion(.right(fake))
    
    }
    
    func cacheNumberTrivia(triviaToCache: NumberTriviaSwift.NumberTriviaModel, completion: @escaping (NumberTriviaSwift.Either<ServerException, NumberTriviaModel>) -> Void) {
        
    }
    
}
class MockNetworkInfo: Mock, NetworkInfo {
    func updateConnectivity() {
        isConnected = true
    }
    
    var isConnected: Bool = true
}

class NumberTriviaRepositoryImplTests: XCTestCase {
    var repository: NumberTriviaRepositoryImpl!
    var mockRemoteDataSource: MockRemoteDataSource!
    var mockLocalDataSource: MockLocalDataSource!
    var mockNetworkInfo: MockNetworkInfo!
    
    override func setUp() {
        super.setUp()
        
        mockRemoteDataSource = MockRemoteDataSource()
        mockLocalDataSource = MockLocalDataSource()
        mockNetworkInfo = MockNetworkInfo()
        repository = NumberTriviaRepositoryImpl(
            remoteDataSource: mockRemoteDataSource,
            localDataSource: mockLocalDataSource,
            networkInfo: mockNetworkInfo
        )
    }
    
    func testGetConcreteNumberTriviaShouldCheckIfDeviceIsOnline() async {
    
        mockNetworkInfo.isConnected = true
        let expected = NumberTrivia(text: "remote number", number: 1)
        // Act
         repository.getConcreteNumberTrivia(params: Params(number: 1), completion: {
            result in
            switch result {
            case .left(let failure):
                print("Error: \(failure)")
            case .right(let numberTrivia):
                XCTAssertEqual( numberTrivia, expected)
            }
        })
        XCTAssertTrue(mockNetworkInfo.isConnected)
    }
    
    
    func testGetRandomNumberTriviaShouldCheckIfDeviceIsOnline() async {
        
        mockNetworkInfo.isConnected = true
        let expected = NumberTrivia(text: "random number", number: 1)
        // Act
         repository.getRandomNumberTrivia(completion: {
            result in
            switch result {
            case .left(let failure):
                print("Error: \(failure)")
            case .right(let numberTrivia):
                XCTAssertEqual( numberTrivia, expected)
            }
        })
        XCTAssertTrue(mockNetworkInfo.isConnected)
    }
    
    func testGetConcreteNumberTriviaShouldCheckIfDeviceIsOffline() async {
        mockNetworkInfo.isConnected = false 
        let expected = NumberTrivia(text: "local number", number: 1)
         repository.getConcreteNumberTrivia(params: Params(number: 1), completion: {
            result in
                    switch result {
                    case .left(let failure):
                        print("Error: \(failure)")
                    case .right(let numberTrivia):
                        XCTAssertEqual( numberTrivia, expected)
                    }
        })
        XCTAssertFalse(mockNetworkInfo.isConnected)
    }
    
    func testGetRandomNumberTriviaShouldCheckIfDeviceIsOffline() async {
        
        mockNetworkInfo.isConnected = false
        let expected = NumberTrivia(text: "local number", number: 1)
        // Act
         repository.getRandomNumberTrivia(completion: {
            result in
            switch result {
            case .left(let failure):
                print("Error: \(failure)")
            case .right(let numberTrivia):
                XCTAssertEqual( numberTrivia, expected)
            }
        })
        XCTAssertFalse(mockNetworkInfo.isConnected)
    }
}
