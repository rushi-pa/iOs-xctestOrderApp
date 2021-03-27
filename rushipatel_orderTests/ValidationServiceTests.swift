//
//  ValidationServiceTests.swift
//  rushipatel_orderTests
//
//  Created by Rushi Patel on 2021-03-26.
//

@testable import rushipatel_order
import XCTest

class ValidationServiceTests: XCTestCase {
    var validation: ValidationService!
        
        override func setUp() {
            super.setUp()
            validation = ValidationService()
        }

        override func tearDown() {
            validation = nil
            super.tearDown()
        }
        
        func test_is_valid_noOfCoffee() throws {
            XCTAssertNoThrow(try validation.validateUsername("15"))
        }
        
        func test_specs_is_nil() throws {
            let expectedError = ValidationError.invalidspecs
            var error: ValidationError?
            
            XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
                error = thrownError as? ValidationError
            }
            
            XCTAssertEqual(expectedError, error)
            
            XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
        }
        
}
