//
//  CalculatorVM.swift
//  StringCalculator
//
//  Created by Akash Sen on 01/07/25.
//

import Foundation
import Combine

enum ExpressionError: LocalizedError {
    case negativeNumberNotAllowed([Int])
    
    var errorDescription: String? {
        switch self {
        case .negativeNumberNotAllowed(let negatives):
            let negativesString = negatives.map(String.init).joined(separator: ", ")
            return negatives.count > 1 ? "Negative numbers \(negativesString) not allowed" : "Negative number not allowed"
        }
    }
}

final class CalculatorVM: ObservableObject {
    @Published var result: Int?
    
    func add(_ expression: String) throws {
        let integers = getIntegers(from: expression)
        
        let negativeIntegers = integers.filter { $0 < 0 }
        if negativeIntegers.isEmpty {
            result = integers.reduce(0, +)
        } else {
            result = nil
            throw ExpressionError.negativeNumberNotAllowed(negativeIntegers)
        }
    }
}

extension CalculatorVM {
    
    /// Converts a given valid string expression into an integer array by splitting it between the delimiters.
    /// - Parameter expression: The string expression to evaluate.
    /// - Returns: Integers that need to be considered for addition.
    ///
    /// Feed expression using "//[delimiter]\n[numbers...]" format to use a custom delimiter.
    private func getIntegers(from expression: String) -> [Int] {
        let processedExpression = expression.replacingOccurrences(of: "\\n", with: "\n")    // Handle escaped newlines from text field input
        
        var numbersString = processedExpression
        var separators = CharacterSet(charactersIn: ",\n")
        
        if processedExpression.hasPrefix("//") {
            let lines = processedExpression.components(separatedBy: "\n")
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
