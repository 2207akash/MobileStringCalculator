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
    
    // MARK: Main Content
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .center) {
                    inputView
                    outputView
                }
            }
            .navigationTitle("String Calculator")
        }
    }
    
    private var headerView: some View {
        Text("String Calculator")
            .font(.largeTitle)
            .foregroundStyle(Color.black)
    }
    
    private var inputView: some View {
        VStack {
            inputTextField
            calculateButton
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

private extension CalculatorView {
    // MARK: Input Views
    private var inputTextField: some View {
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
    }
    
    private var calculateButton: some View {
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

#Preview {
    CalculatorView()
}
