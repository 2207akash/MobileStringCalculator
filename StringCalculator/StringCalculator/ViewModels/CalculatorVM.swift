//
//  CalculatorVM.swift
//  StringCalculator
//
//  Created by Akash Sen on 01/07/25.
//

import Foundation
import Combine

final class CalculatorVM: ObservableObject {
    @Published var result: Int?
    
    func add(_ expression: String) {
        let integers = getIntegers(from: expression)
        result = integers.reduce(0, +)
    }
}

extension CalculatorVM {
    
    /// Converts a given valid string expression into an integer array by splitting it between the delimiters.
    /// - Parameter expression: The string expression to evaluate.
    /// - Returns: Integers that need to be considered for addition.
    ///
    /// Feed expression using "//[delimiter]\n[numbers...]" format to use a custom delimiter.
    private func getIntegers(from expression: String) -> [Int] {
        var numbersString = expression
        var separators = CharacterSet(charactersIn: ",\n")
        
        if expression.hasPrefix("//") {
            let lines = expression.components(separatedBy: "\n")
            if lines.count >= 2 {
                let delimiterLine = lines[0]
                let numbersLine = lines[1]
                
                // Extract delimiter from "//[delimiter]"
                let delimiterStartIndex = delimiterLine.index(delimiterLine.startIndex, offsetBy: 2)
                let delimiter = String(delimiterLine[delimiterStartIndex...])
                
                // Use custom delimiter
                separators = CharacterSet(charactersIn: delimiter)
                numbersString = numbersLine
            }
        }
        
        return numbersString.components(separatedBy: separators).compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
    }
    
}
