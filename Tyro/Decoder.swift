//
//  Decoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONDecoderType {
    typealias DecodedType = AnyObject
    func decodeEither(value : JSONValue) -> Either<JSONError, DecodedType>
    func decode(value : JSONValue) -> DecodedType?
}

public class JSONDecoder : JSONDecoderType {
    public static let decoder = JSONDecoder()
    private init() {}
    
    public func decodeEither(value : JSONValue) -> Either<JSONError, AnyObject> {
        switch value {
        case .Array(let values):
            return .Right(values.flatMap { $0.anyObject })
        case .Object(let value):
            return .Right(value.mapMaybe { $0.anyObject })
        case .Number(let n):
            return .Right(n)
        case .String(let s):
            return .Right(s)
        case .Null:
            return .Right(NSNull())
        case .Lazy(let closure):
            let v: JSONValue = closure()
            let ab = decodeEither(v)
            return ab
        }
    }
}

extension JSONDecoderType {
    public func decode(value : JSONValue) -> DecodedType? {
        return decodeEither(value).right
    }
}

extension JSONValue : JSONDecoderType {
    public func decodeEither(value : JSONValue) -> Either<JSONError, JSONValue> {
        return jsonValue.toEither(.Custom("Could not decode JSONValue from JSONValue. There must be a problem."))
    }
}

extension JSONValue : JSONValueConvertible {
    public var jsonValue : JSONValue? { return self }
}
