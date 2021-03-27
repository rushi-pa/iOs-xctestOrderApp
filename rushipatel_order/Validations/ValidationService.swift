//
//  order_validator.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-03-26.
//

import Foundation
struct ValidationService {
    func validateUsername(_ noOfCoffee: String?) throws -> String {
        guard let noOfCoffee = noOfCoffee else { throw ValidationError.invalidsize}
        
        return noOfCoffee
    }
    
    func validatePassword(_ spec: String?) throws -> String {
        guard let spec = spec else { throw ValidationError.invalidspecs }
       
        return spec
    }
}

enum ValidationError : LocalizedError{
    case invalidvalue;
    case invalidsize;
    case invalidspecs;
    
    var errorDescription: String?{
        switch self {
        case .invalidvalue:
            return "Field/(s) empty";
        case .invalidsize:
            return "Invalid size";
        case .invalidspecs:
            return "Instructions unclear";
        }
    }
}

