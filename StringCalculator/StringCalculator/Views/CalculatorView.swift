//
//  CalculatorView.swift
//  StringCalculator
//
//  Created by Akash Sen on 01/07/25.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var vm = CalculatorVM()
    @State private var expression = ""
    @State private var expressionErrorString: String?
    
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
            .keyboardType(.asciiCapable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay {
                if expressionErrorString != nil {
                    RoundedRectangle(cornerRadius: 4)
                        .strokeBorder(Color.red)
                }
            }
            .padding()
            
            Button("Calculate") {
                do {
                    expressionErrorString = nil
                    try vm.add(expression)
                } catch (let error) {
                    expressionErrorString = error.localizedDescription
                }
            }
        }
    }
    
    private var outputView: some View {
        VStack {
            if let result = vm.result {
                Text("Result: \(result)")
            }
            if let expressionErrorString = expressionErrorString {
                Text(expressionErrorString)
                    .foregroundColor(.red)
            }
        }
        .padding(.top)
    }
}

#Preview {
    CalculatorView()
}
