//
//  JSON.swift
//  FFHonoluluArt
//
//  Created by zhou on 2019/7/23.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import Foundation

enum JSONValue {
    case jsonObject([String: JSONValue])
    case jsonArray([JSONValue])
    case jsonString(String)
    case jsonNumber(NSNumber)
    case jsonBool(Bool)
    case jsonNull
    
    var object: [String: JSONValue]? {
        switch self {
        case .jsonObject(let value):
            return value
        default:
            return nil
        }
    }
    
    var array: [JSONValue]? {
        switch self {
        case .jsonArray(let value):
            return value
        default:
            return nil
        }
    }
    
    var string: String? {
        switch self {
        case .jsonString(let value):
            return value
        default:
            return nil
        }
    }
    
    var integer: Int? {
        switch self {
        case .jsonNumber(let value):
            return value.intValue
        default:
            return nil
        }
    }
    
    var double: Double? {
        switch self {
        case .jsonNumber(let value):
            return value.doubleValue
        default:
            return nil
        }
    }
    
    var bool: Bool? {
        switch self {
        case .jsonBool(let value):
            return value
        case .jsonNumber(let value):
            return value.boolValue
        default:
            return nil
        }
    }
    
    subscript(i: Int) -> JSONValue? {
        get {
            switch self {
            case .jsonArray(let value):
                return value[i]
            default:
                return nil
            }
        }
    }
    
    subscript(key: String) -> JSONValue? {
        get {
            switch self {
            case .jsonObject(let value):
                return value[key]
            default:
                return nil
            }
        }
    }
    
    static func fromObject(_ object: Any) -> JSONValue? {
        switch object {
        case let value as NSString:
            return JSONValue.jsonString(value as String)
        case let value as NSNumber:
            return JSONValue.jsonNumber(value)
        case _ as NSNull:
            return JSONValue.jsonNull
        case let value as NSDictionary:
            var jsonObject: [String: JSONValue] = [:]
            for (k, v) in value {
                if let k = k as? NSString {
                    if let v = JSONValue.fromObject(v as Any) {
                        jsonObject[k as String] = v
                    } else {
                        return nil
                    }
                }
            }
            return JSONValue.jsonObject(jsonObject)
        case let value as NSArray:
            var jsonArray: [JSONValue] = []
            for v in value {
                if let v = JSONValue.fromObject(v as Any) {
                    jsonArray.append(v)
                } else {
                    return nil
                }
            }
            return JSONValue.jsonArray(jsonArray)
        default:
            return nil
        }
    }
}
