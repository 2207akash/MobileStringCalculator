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
    
    func testInitialResultValue() {
        XCTAssertNil(vm.result)
    }
    
    func testCalculateOnEmptyInput() {
        let expression = ""
        vm.add(expression)
        XCTAssertEqual(vm.result, 0)
    }
    
    func testCalculateOnSingleInput() {
        let expression = "1"
        vm.add(expression)
        XCTAssertEqual(vm.result, 1)
    }
    
    func testCalculateOnCommaSeperatedInput() throws {
        let expression = "1,2,3"
        vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnNewLineSeperatedInput() throws {
        let expression = "1\n2\n3"
        vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnMixedSeparatorsInput() throws {
        let expression = "1\n2,3"
        vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
    
    func testCalculateOnCustomDelimiterInput() throws {
        let expression = "//;\n1;2;3"
        vm.add(expression)
        XCTAssertEqual(vm.result, 6)
    }
}
