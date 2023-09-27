//
//  JsonToStringTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

@testable import NumberTriviaSwift
import XCTest

class JsonToStringTest: XCTestCase {
    let tNumberTriviaModel = NumberTriviaModel(text: "Test Text",number: 1);
    
    func testIsExistingFile()  async {
        let result =  await JsonToString.jsonToString(filename: "trivia", ext: "json")
        switch result {
            case .right(let str):
                XCTAssertTrue(str is String)
            case .left:
                XCTFail("Expected a successful result")
        }
    }
    
    func testIsNoneExistingFile()  async {
        let result =  await JsonToString.jsonToString(filename: "blablabla", ext: "json")
        switch result {
        case .right:
            XCTFail("Expected a successful result")
        case .left(let jsonFailure):
            XCTAssertEqual(jsonFailure, .notFound)
        }
    }
}
