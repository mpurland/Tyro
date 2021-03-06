//
//  Types.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

/// String
extension String : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, String> {
        switch value {
        case .String(let value):
            return .Right(value)
        case .Number(let value):
            return .Right(value.stringValue)
        default:
            return .Left(.TypeMismatch("\(String.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension String : ToJSON {
    public static func toJSON(value : String) -> Either<JSONError, JSONValue> {
        return .Right(.String(value))
    }
}

/// Bool
extension Bool : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Bool> {
        switch value {
        case .Number(0), .Number(false):
            return .Right(false)
        case .Number(1), .Number(true):
            return .Right(true)
        default:
            return .Left(.TypeMismatch("\(Bool.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Bool : ToJSON {
    public static func toJSON(value : Bool) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

/// Int
extension Int : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Int> {
        return value.number.map { $0.integerValue }.toEither(.TypeMismatch("\(Int.self)", "\(value.dynamicType.self)"))
    }
}

extension Int : ToJSON {
    public static func toJSON(value : Int) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

/// Int8
extension Int8 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Int8> {
        return value.number.map { $0.charValue }.toEither(.TypeMismatch("\(Int8.self)", "\(value.dynamicType.self)"))
    }
}

extension Int8 : ToJSON {
    public static func toJSON(value : Int8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(char : value)))
    }
}

/// Int16
extension Int16 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Int16> {
        return value.number.map { $0.shortValue }.toEither(.TypeMismatch("\(Int16.self)", "\(value.dynamicType.self)"))
    }
}

extension Int16 : ToJSON {
    public static func toJSON(value : Int16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(short : value)))
    }
}

/// Int32
extension Int32 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Int32> {
        return value.number.map { $0.intValue }.toEither(.TypeMismatch("\(Int32.self)", "\(value.dynamicType.self)"))
    }
}

extension Int32 : ToJSON {
    public static func toJSON(value : Int32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(int : value)))
    }
}

/// Int64
extension Int64 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Int64> {
        return value.number.map { $0.longLongValue }.toEither(.TypeMismatch("\(Int64.self)", "\(value.dynamicType.self)"))
    }
}

extension Int64 : ToJSON {
    public static func toJSON(value : Int64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(longLong : value)))
    }
}

/// UInt
extension UInt : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, UInt> {
        return value.number.map { $0.unsignedLongValue }.toEither(.TypeMismatch("\(UInt.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt : ToJSON {
    public static func toJSON(value : UInt) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedLong : value)))
    }
}

/// UInt8
extension UInt8 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, UInt8> {
        return value.number.map { $0.unsignedCharValue }.toEither(.TypeMismatch("\(UInt8.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt8 : ToJSON {
    public static func toJSON(value : UInt8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedChar : value)))
    }
}

/// UInt16
extension UInt16 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, UInt16> {
        return value.number.map { $0.unsignedShortValue }.toEither(.TypeMismatch("\(UInt16.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt16 : ToJSON {
    public static func toJSON(value : UInt16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedShort : value)))
    }
}

/// UInt32
extension UInt32 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, UInt32> {
        return value.number.map { $0.unsignedIntValue }.toEither(.TypeMismatch("\(UInt32.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt32 : ToJSON {
    public static func toJSON(value : UInt32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedInt : value)))
    }
}

/// UInt64
extension UInt64 : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, UInt64> {
        return value.number.map { $0.unsignedLongLongValue }.toEither(.TypeMismatch("\(UInt64.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt64 : ToJSON {
    public static func toJSON(value : UInt64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedLongLong : value)))
    }
}

/// Float
extension Float : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Float> {
        return value.number.map { $0.floatValue }.toEither(.TypeMismatch("\(Float.self)", "\(value.dynamicType.self)"))
    }
}

extension Float : ToJSON {
    public static func toJSON(value : Float) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(float : value)))
    }
}

/// Double
extension Double : FromJSON {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, Double> {
        return value.number.map { $0.doubleValue }.toEither(.TypeMismatch("\(Double.self)", "\(value.dynamicType.self)"))
    }
}

extension Double : ToJSON {
    public static func toJSON(value : Double) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(double : value)))
    }
}