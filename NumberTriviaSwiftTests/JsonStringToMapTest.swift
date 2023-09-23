//
//  JsonStringToMapTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 22/09/2023.
//

@testable import NumberTriviaSwift
import XCTest

class JsonStringToMapTest: XCTestCase {
    let tNumberTriviaModel = NumberTriviaModel(text: "Test Text",number: 1);
    
    func testIsValidString()  async {
        let str =  """
        {
            "text": "Test Text",
            "number": 1,
            "found": true,
            "type": "trivia"
        }
        """
        let result =  await JsonStringToMap.jsonStringToMap(str: str)
        
        switch result {
        case .right(let str):
            XCTAssertTrue(str is [String: Any])
        case .left:
            XCTFail("Expected a successful result")
        }
    }
    
    func testIsInvalidString()  async {
        let str =  """
        {
            "text": "Test Text",
            5: 1,
            "found": true,
            true: "trivia"
        }
        """
        let result =  await JsonStringToMap.jsonStringToMap(str: str)
        switch result {
        case .right:
            XCTFail("Expected an error")
        case .left(let err):
            XCTAssertTrue(err is JsonMapFailure)
        }
    }
}
