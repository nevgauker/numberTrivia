//
//  NumberTriviaRemoteDataSourceImplTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 25/09/2023.
//

//
//  NumberTriviaLocalDataSourceImplTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 24/09/2023.
//

import XCTest
@testable import NumberTriviaSwift



class NumberTriviaRemoteDataSourceImplTests: XCTestCase {
    
    var remotelDataSourceImpl:NumberTriviaRemoteDataSourceImpl!
    
    override func setUp() {
        super.setUp()
        remotelDataSourceImpl = NumberTriviaRemoteDataSourceImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testFetchDataSuccess() async {
        remotelDataSourceImpl.getRandomNumberTrivia() { result in
            
            switch result {
            case .right(let number):
                XCTAssertNotNil(number, "Data should not be nil")
            case .left:
                XCTFail("shsould return data if service and connection are valid" )
            }
        }
    }
    func testFetchDataSuccessWithNumber() async {
        
        let number  = 42
        remotelDataSourceImpl.getConcreteNumberTrivia(number:number) { result in
            
            switch result {
            case .right(let number):
                XCTAssertNotNil(number, "Data should not be nil")
            case .left:
                XCTFail("shsould return data if service and connection are valid" )
            }
        }
    }
}
