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
        ZStack {
            backgroundColor
            VStack(alignment: .center) {
                inputView
                outputView
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("String Calculator")
                    .foregroundColor(.primaryText)
                    .font(.headline)
            }
        }
    }
    
    private var backgroundColor: some View {
        Color.appBackground
            .ignoresSafeArea()
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
                    .foregroundStyle(.primaryText)
            }
            if let expressionErrorString = expressionErrorString {
                Text(expressionErrorString)
                    .foregroundColor(.errorText)
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
        .foregroundStyle(.primaryText)
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
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .font(.headline)
        .foregroundStyle(.buttonText)
        .tint(.buttonBackground)
        .padding()
    }
}

#Preview {
    CalculatorView()
}
