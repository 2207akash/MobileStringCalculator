//
//  StringCalculatorTests.swift
//  StringCalculatorTests
//
//  Created by Akash Sen on 01/07/25.
//

import XCTest
@testable import StringCalculator

final class CalculatorVMTests: XCTestCase {
    var vm: CalculatorVM!

    override func setUpWithError() throws {
        vm = CalculatorVM()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

}

extension CalculatorVMTests {
    
    func testInitialResultValue() throws {
        XCTAssertNil(vm.result)
    }
    
    func testCalculateOnEmptyInput() throws {
        let expression = ""
        try vm.add(expression)
        XCTAssertEqual(vm.result, 0)
    }
    
    func testCalculateOnSingleInput() throws {
        let expression = "1"
        try vm.add(expression)
        XCTAssertEqual(vm.result, 1)
    }
    
    func testCalculateOnCommaSeperatedInput() throws {
        let expression = "1,2,3"
        try vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnNewLineSeperatedInput() throws {
        let expression = "1\n2\n3"
        try vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnMixedSeparatorsInput() throws {
        let expression = "1\n2,3"
        try vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnCustomDelimiterInput() throws {
        let expression = "//;\n1;2;3"
        try vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnNegativeNumberInput() throws {
        let expression = "-1,2,3"
        XCTAssertThrowsError(try vm.add(expression))
        XCTAssertNil(vm.result)
    }
    
    func testCalculateOnNegativeNumberCustomDelimiterInput() throws {
        let expression = "//;\n-1;2;3"
        XCTAssertThrowsError(try vm.add(expression))
        XCTAssertNil(vm.result)
    }
}
