//
//  CalculatorView.swift
//  StringCalculator
//
//  Created by Akash Sen on 01/07/25.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var vm = CalculatorVM()
    @State private var expression: String = ""
    
    var body: some View {
        VStack {
            inputView
            outputView
        }
    }
    
    private var inputView: some View {
        VStack {
            TextField(
                "Enter your expression here",
                text: $expression
            )
            .font(.body)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            Button("Calculate") {
                vm.add(expression)
            }
        }
    }
    
    private var outputView: some View {
        VStack {
            if let result = vm.result {
                Text("Result: \(result)")
                    .padding(.top)
            }
        }
    }
}

#Preview {
    CalculatorView()
}
