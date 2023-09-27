//
//  NumberTriviaModelTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 21/09/2023.
//
@testable import NumberTriviaSwift
import XCTest

class NumberTriviaModelTest: XCTestCase {
    let tNumberTriviaModel = NumberTriviaModel(text: "Test Text",number: 1);
// from jsosn
    func testMapToObject() {
        let map:[String: Any] = [ "text": "Test Text" , "number": 1,  "found": true, "type": "trivia"]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNotNil(model)
    }
    
    func testMapToObjectWithDoubleNumber() {
        let map:[String: Any] = [ "text": "Test Text" , "number": 1.0,  "found": true, "type": "trivia"]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNotNil(model)
    }
    
    func testMapWithNoTextAndNumber() {
        let map:[String: Any] = [ "bla": "Test Text"]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNil(model)
    }
    
    func testMapWithumberNoText() {
        let map:[String: Any] = [ "number" : 5 , "bla": "Test Text"]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNil(model)
    }
    func testMapWithTextNoNumber() {
        let map:[String: Any] = [ "text" : "text" , "bla": "Test Text"]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNil(model)
    }
    func testEmptyMap() {
        let map:[String: Any] = [:]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNil(model)
    }
    //tets for too big double number
    func testMapWithTextAndTooBigNumber() {
        
        let map:[String: Any] = [ "text" : "text" , "number": 132434324535354335543535535.5345435435]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNil(model)
    }
    func testMapWithTextAndValidDoubleNumber() {
      //  let maxSafeDoubleToInt = Double(Int.max)

        let map:[String: Any] = [ "text" : "text" , "number": 3243243322123.24]
        let model = NumberTriviaModel.fromJson(json: map)
        XCTAssertNotNil(model)
    }
    
    
    // to json
    func testObjectToMap() {
        let obj = NumberTriviaModel(text: "Test Text", number: 1)
        let expected:[String: Any] = [ "text": "Test Text","number":1]
        let result  = NumberTriviaModel.toJson(obj: obj)
        assertDictionariesEqual(result, expected, message: "Dictionaries are not equal")

    }
    
    func assertDictionariesEqual(_ dict1: [String: Any]?, _ dict2: [String: Any], message: String) {
        
        if ((dict1 == nil)) {
            XCTFail("This test always fails")
        }else {
            for (key, value) in dict1! {
                XCTAssertEqual(dict2[key] as? NSObject, value as? NSObject, "Key: \(key) - \(message)")
            }
        }
    }
}
