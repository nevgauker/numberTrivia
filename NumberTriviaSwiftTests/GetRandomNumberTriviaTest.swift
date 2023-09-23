//
//  GetRandomNumberTriviaTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation

//
//  NumberTriviaRepositoryTests.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 21/09/2023.
//
@testable import NumberTriviaSwift
import XCTest

class GetRandomNumberTriviaTest: XCTestCase {
    
    let repository = MockNumberTriviaRepository()
    
    func testGetRandomNumberTrivia() {
     
        let expectedTrivia = NumberTrivia(text: "Random trivia", number: 42) // Change to your test data
        
        let expectation = XCTestExpectation(description: "Fetching random number trivia")
        
        repository.getRandomNumberTrivia { result in
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
}
