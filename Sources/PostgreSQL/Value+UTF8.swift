//
//  Value+UTF8.swift
//  PostgreSQL
//
//  Created by Prince Ugwuh on 7/13/16.
//
//

import Foundation


extension Value {
    var utf8: String.UTF8View {
        switch self {
        case .string(let str):
            return str.utf8
        case .double(let double):
            return String(double).utf8
        case .int(let int):
            return String(int).utf8
        case .bool(let bool):
            return bool == 1 ? "true".utf8 : "false".utf8
        case .null:
            return "".utf8
        }
    }
}
