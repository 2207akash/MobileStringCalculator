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
    
    func calculate(expression: String) {
        let integers = getIntegers(from: expression)
        result = integers.reduce(0, +)
    }
}

extension CalculatorVM {
    
    private func getIntegers(from expression: String) -> [Int] {
        let separators = CharacterSet(charactersIn: ",\n")
        return expression.components(separatedBy: separators).compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
    }
    
}
