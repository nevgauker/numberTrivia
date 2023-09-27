//
//  InputConverterTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 25/09/2023.
//

import XCTest
@testable import NumberTriviaSwift



class InputConverterTests: XCTestCase {
    
    func testValidPostiveNNumberString()  {
        let numberStr =  "5"
        let result = InputConverter.stringToUnsignedInteger(numStr: numberStr)
        switch result {
        case .left( _):
            XCTFail("coverting error")
        case .right(let num):
            XCTAssertEqual(num, 5)
        }
    }
    func testInvalidNegativeNNumberString()  {
        let numberStr =  "-5"
        let result = InputConverter.stringToUnsignedInteger(numStr: numberStr)
        switch result {
        case .left( let failure):
            XCTAssertEqual(failure, Failure.noPositiveNumber)
        case .right(_):
            XCTFail("shouldnnot return number")
        }
    }
    func testInvalidGeneralrString()  {
        let numberStr =  "%"
        let result = InputConverter.stringToUnsignedInteger(numStr: numberStr)
        switch result {
        case .left( let failure):
            XCTAssertEqual(failure, Failure.noPositiveNumber)
        case .right(_):
            XCTFail("shouldnnot return number")
        }

    }
      
}
