//
//  TyroSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/18/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class TyroSpec: XCTestCase {
    let json = "{\"bool\":true,\"intOrBool\":1}"
    let invalidJson = "{\"bool\"\":true,\"intOrBool\":1}"
    let arrayBoolJson = "{\"bools\":[true,true,false,false]}"
    let dictionaryJson = "{\"object\":{\"bool\":true}}"
    
    func testToJSONEither() {
        let either = json.toJSONEither
        
        XCTAssertNil(either?.left)
        XCTAssertNotNil(either?.right)
        
        XCTAssertNotNil(invalidJson.toJSONEither?.left)
    }
    
    func testToJSON() {
        let jsonValue: JSONValue? = json.toJSON
        XCTAssertNotNil(jsonValue)
        
        let invalidJsonValue: JSONValue? = invalidJson.toJSON
        XCTAssertNil(invalidJsonValue)
    }
    
    func testEitherCoalescing() {
        let result1: JSONValue? = json.toJSONEither | .Null
        let result2: JSONValue? = invalidJson.toJSONEither | .Null
        XCTAssert(result1 != .Null)
        XCTAssert(result2 == .Null)
        
        let result3: JSONValue? = json.toJSONEither | nil
        let result4: JSONValue? = invalidJson.toJSONEither | nil
        XCTAssert(result3 != nil)
        XCTAssertNil(result4)
    }
    
    func testSubscript() {
        let either = json.toJSONEither
        let jsonValue = either?.right?["bool"]
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == JSONValue.Number(true))
    }
    
    func testValue() {
        let either = json.toJSONEither
        XCTAssertNotNil(either?.right)
        
        let bool: Bool? = either?.right?["bool"]?.value()
        XCTAssertNotNil(bool)
        XCTAssert(bool == true)
        
        let intOrBool: Int? = either?.right?["intOrBool"]?.value()
        XCTAssertNotNil(intOrBool)
        XCTAssert(intOrBool == 1)
    }
    
    func testValueArray() {
        let result = arrayBoolJson.toJSONEither?.right
        XCTAssertNotNil(result)
        
        let jsonValue: JSONValue? = result?["bools"]
        let bools: [Bool]? = jsonValue?.value()
        
        XCTAssertNotNil(bools)
        XCTAssert(bools?.count == 4)
        XCTAssert(bools! == [true, true, false, false])
    }
    
    func testValueDictionary() {
        let result = dictionaryJson.toJSONEither?.right
        XCTAssertNotNil(result)
        
        let object: [String: Bool]? = result <? "object"
        XCTAssertNotNil(object)
        XCTAssert(object?["bool"] == true)
        
        let bool1: Bool? = result?["object"]?["bool"]?.value()
        
        XCTAssertNotNil(bool1)
        XCTAssert(bool1 == true)
    }
    
    func testKeypath() {
        let result = dictionaryJson.toJSONEither?.right
        XCTAssertNotNil(result)
        
        let bool2: Bool? = result <? "object" <> "bool"
        XCTAssertNotNil(bool2)
        XCTAssert(bool2 == true)
    }
    
    func testOperatorRetrieve() {
        let x: JSONValue? = json.toJSONEither?.right
        XCTAssertNotNil(x)
        
        let bool: Bool? = x <? "bool"
        
        XCTAssertNotNil(bool)
        XCTAssert(bool == true)
    }
    
    func testDate() {
        let timestampInMilliseconds: Double = 1443769200000
        let expectedDate = NSDate(timeIntervalSince1970: 1443769200000.0 / 1000.0)
        let datesJson = "{\"lastUpdated\":\(timestampInMilliseconds),\"lastUpdatedPretty\":\"2015-10-02 07:00:00 +0000\",\"dates\":[\"2015-10-02 07:00:00 +0000\",\"2015-10-02 08:00:00 +0000\",\"2015-10-02 09:00:00 +0000\"],\"object\":{\"date\":\(timestampInMilliseconds)}}"
        let result = datesJson.toJSONEither?.right
        
        XCTAssertNotNil(result)
        
        let date1: NSDate? = result?.format(DateTimestampJSONFormatter.self) <? "lastUpdated"
        XCTAssertNotNil(date1)
        
        let date2: NSDate? = result?.format(DateFormatJSONFormatter.self) <? "lastUpdatedPretty"
        XCTAssertNotNil(date2)
        
        let dates: [NSDate]? = result?.format(DateFormatJSONFormatter.self) <? "dates"
        XCTAssert(dates?.count == 3)
        
        let object: [String: NSDate]? = result?.format(DateTimestampJSONFormatter.self) <? "object"
        XCTAssert(object?.keys.count == 1)
        XCTAssert(object?["date"] == expectedDate)
    }
}