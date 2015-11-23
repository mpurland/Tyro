//
//  TyroTests.swift
//  Tyro
//
//  Created by Matthew Purland on 11/22/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation

import Swiftz
@testable import Tyro

extension String {
    func loadDataFromFile() -> NSData? {
        let data = NSData(contentsOfFile: self)
        return data
    }
    
    func pathForFile(name: String, ofType: String) -> String? {
        return NSBundle(forClass: TyroTests.self).pathForResource(name, ofType: ofType)
    }
    
    func loadJSONFromFile(name: String) -> JSONValue? {
        return (JSONValue.decode <^> pathForFile(name, ofType: "json")?.loadDataFromFile()) ?? nil
    }
    
    var jsonFromFile: JSONValue? {
        return loadJSONFromFile(self)
    }
}

private class TyroTests {}