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
    func getConcreteNumberTrivia(number: Int) async throws -> NumberTriviaModel {
        let fake = NumberTriviaModel(text: "remote number", number: 1)
        return fake
    }
    
    func getRandomNumberTrivia() async throws -> NumberTriviaModel {
        let fake = NumberTriviaModel(text: "random number", number: 1)
        return fake
    }
    
}
class MockLocalDataSource: Mock, NumberTriviaLocalDataSource {
    func getLastNumberTrivia() async throws -> NumberTriviaModel {
        let fake = NumberTriviaModel(text: "local number", number: 1)
        return fake
    }
    
    func cacheNumberTrivia(triviaToCache: NumberTriviaModel) async {
        
    }
    
}
class MockNetworkInfo: Mock, NetworkInfo {
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
        await repository.getConcreteNumberTrivia(params: Params(number: 1), completion: {
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
        await repository.getConcreteNumberTrivia(params: Params(number: 1), completion: {
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
