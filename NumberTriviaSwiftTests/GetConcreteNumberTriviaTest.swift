//
//  NumberTriviaRepositoryTests.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 21/09/2023.
//
@testable import NumberTriviaSwift
import XCTest

class GetConcreteNumberTriviaTest: XCTestCase {
  
    let repository = MockNumberTriviaRepository()
    
    
    func testGetConcreteNumberTrivia() {
        let expectedTrivia = NumberTrivia(text: "Test trivia", number: 5) // Change to your test data
        
        let expectation = XCTestExpectation(description: "Fetching concrete number trivia")
        
        repository.getConcreteNumberTrivia(params: Params(number: 5)) { result in
            switch result {
            case .right(let trivia):
                XCTAssertEqual(trivia, expectedTrivia)
            case .left:
                XCTFail("Expected a successful result")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust the timeout as needed
    }
    
    
    func testGetConcreteNumberTriviaNoParams() {
        
        let expectation = XCTestExpectation(description: "Fetching concrete number trivia")
        
        repository.getConcreteNumberTrivia(params: nil) { result in
            switch result {
            case .right(_):
                XCTFail("Expected a successful result")
            case .left:
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust the timeout as needed
    }

}
