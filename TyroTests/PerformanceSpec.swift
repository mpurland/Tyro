//
//  PerformanceSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/22/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

struct BigDataUser {
    let id : Int
    let name : String
    let email : String?
    
    static func create(id : Int)(name : String)(email : String?) -> BigDataUser {
        return BigDataUser(id: id, name: name, email: email)
    }
}

extension BigDataUser: FromJSON {
    static func fromJSON(value : JSONValue) -> Either<JSONError, BigDataUser> {
        let p1 : Int? = value <? "id"
        let p2 : String? = value <? "name"
        let p3 : String?? = value <?? "email"
        
        return (BigDataUser.create
            <^> p1
            <*> p2
            <*> p3).toEither(.Custom("Could not create test model user"))
    }
}

struct BigDataTestModel {
    let int : Int
    let double : Double
    let float : Float
    let bool : Bool
    let intOpt : Int?
    let stringArray : [String]
    let embeddedStringArray : [String]
    let embeddedStringArrayOpt : [String]?
    let userOpt : BigDataUser?
    
    static func create(int : Int)(_ double : Double)(_ float : Float)(_ bool : Bool)(_ intOpt : Int?)(_ stringArray : [String])(_ embeddedStringArray : [String])(_ embeddedStringArrayOpt : [String]?)(_ userOpt : BigDataUser?) -> BigDataTestModel {
        return BigDataTestModel(int: int, double: double, float: float, bool: bool, intOpt: intOpt, stringArray: stringArray, embeddedStringArray: embeddedStringArray, embeddedStringArrayOpt: embeddedStringArrayOpt, userOpt: userOpt)
    }
}

extension BigDataTestModel: FromJSON {
    static func fromJSON(value : JSONValue) -> Either<JSONError, BigDataTestModel> {
        let p1 : Int? = value <? "int"
        let p2 : Double? = value <? "double"
        let p3 : Float? = value <? "float"
        let p4 : Bool? = value <? "bool"
        let p5 : Int?? = value <?? "int_opt"
        let p6 : [String]? = value <? "string_array"
        let p7 : [String]? = value <? "embedded" <> "string_array"
        let p8 : [String]?? = value <?? "embedded" <> "string_array_opt"
        let p9 : BigDataUser?? = value <?? "user_opt"
        
        let tm = BigDataTestModel.create
            <^> p1
            <*> p2
            <*> p3
            <*> p4
            <*> p5
            <*> p6
            <*> p7
            <*> p8
            <*> p9
        
        return tm.toEither(.Custom("Could not create test model"))
    }
}

//extension XCTestCase {
//    func measureBlock(maxTimeInterval: NSTimeInterval, block: () -> ()) {
//        measureBlock {
//            let before = NSDate()
//            block()
//            let after = NSDate()
//            XCTAssertLessThan(after.timeIntervalSinceDate(before), maxTimeInterval)
//        }
//    }
//}

class PerformanceSpec: XCTestCase {
    func testDecoderPerformance() {
        measureBlock {
            let jsonValue = "big_data".jsonFromFile
            XCTAssertNotNil(jsonValue)
        }
    }
    
    func testJSONValueFromJSONPerformance() {
        measureBlock {
            let jsonValue = "big_data".jsonFromFile
            let testModel: [BigDataTestModel]? = jsonValue <? "types"
            XCTAssert(testModel?.count == 255)
        }
    }
}
