//
//  CalculatorModel.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import Foundation

struct CalculatorModel {
    let operators = ["/", "+", "X", "%"]
    
    func validInput(_ input: String) -> Bool{
        guard !input.isEmpty, let last = input.last else {
            return false
        }
        let lastChar = String(last)
        
        if operators.contains(lastChar) || lastChar == "-" {
             if lastChar != "%" || input.count == 1 {
                 return false
             }
         }
        return true
    }
    
    func calculateResults(_ input: String) -> Double? {
        var working = input.replacingOccurrences(of: "%", with: "*0.01")
        working = working.replacingOccurrences(of: "X", with: "*")
        
        let expression = NSExpression(format: working)
        return expression.expressionValue(with: nil, context: nil) as? Double
    }
    
    func formatResult(val: Double) -> String {
        return val.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", val)
        : String(format: "%.2f", val)
    }
}
