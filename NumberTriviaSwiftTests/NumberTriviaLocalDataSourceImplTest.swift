//
//  NumberTriviaLocalDataSourceImplTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 24/09/2023.
//

import XCTest
@testable import NumberTriviaSwift



class NumberTriviaLocalDataSourceImplTests: XCTestCase {
    
    var localDataSourceImpl:NumberTriviaLocalDataSourceImpl!
    let standard = UserDefaults.standard
    
    override func setUp() {
        super.setUp()
        localDataSourceImpl = NumberTriviaLocalDataSourceImpl()
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey:localDataSourceImpl.NumberKey)
        UserDefaults.standard.removeObject(forKey: localDataSourceImpl.TextKey)
        super.tearDown()
    }
    
    
    func testGetLastNumberTrivia() async{
        //fake erlier cache
        let expected = NumberTriviaModel(text: "test number", number: 1)
        
        UserDefaults.standard.set(expected.number, forKey: localDataSourceImpl.NumberKey)
        UserDefaults.standard.set(expected.text, forKey: localDataSourceImpl.TextKey)
        
        localDataSourceImpl.getLastNumberTrivia() { result in
            switch result {
            case .left(_ ):
                XCTFail("Expected an error")
            case .right(let numberTrivia):
                XCTAssertEqual(numberTrivia, expected)
            }
        }
        
    }
    
    func testGetLastNumberTriviaNoResult() async{
        //make sure it does not cached
        UserDefaults.standard.removeObject(forKey: localDataSourceImpl.NumberKey)
        UserDefaults.standard.removeObject(forKey: localDataSourceImpl.TextKey)
        localDataSourceImpl.getLastNumberTrivia() { result in
            switch result {
            case .left( let failue ):
                XCTAssertEqual(failue, .CacheException)
            case .right(_ ):
                XCTFail("nothing supposd to be cached")
            }
        }
    }
    
    func testcacheNumberTrivia() async{
        
        let numberObj = NumberTriviaModel(text: "test number", number: 1)
        localDataSourceImpl.cacheNumberTrivia(triviaToCache: numberObj) { result in
            switch result {
            case .left( _  ):
                XCTFail("should not happen")
            case .right(let numberTrivia):
                XCTAssertEqual(numberTrivia, numberObj)
                let text:String? =  self.standard.string(forKey:self.localDataSourceImpl.TextKey)
                let number =  self.standard.integer(forKey:self.localDataSourceImpl.NumberKey)
                XCTAssertEqual(text, numberTrivia.text)
                XCTAssertEqual(number, numberTrivia.number)
            }
        }
    }
}
