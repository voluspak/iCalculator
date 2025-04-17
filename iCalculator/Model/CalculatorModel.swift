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
        let working = normalizeInput(from: input)
        
        let expression = NSExpression(format: working)
        let value = expression.expressionValue(with: nil, context: nil) as? Double
        print("Resultado bruto: ", value ?? -999)
        return value
    }
    
    private func normalizeInput(from input: String) -> String {
        let replaced = input
            .replacingOccurrences(of: "%", with: "*0.01")
            .replacingOccurrences(of: "X", with: "*")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        let normalizedInput = forceDoubleOperands(in: replaced)
        return normalizedInput
    }
    
    private func forceDoubleOperands(in input: String) -> String {
        // Buscar números enteros que no están seguidos por un punto decimal
        let pattern = #"(?<![\.\d])(\d+)(?![\.\d])"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(input.startIndex..., in: input)
        var result = input
        var offset = 0

        regex?.enumerateMatches(in: input, options: [], range: range) { match, _, _ in
            guard let match = match, let numberRange = Range(match.range(at: 1), in: result) else { return }
            let adjustedStart = result.index(numberRange.lowerBound, offsetBy: offset)
            let adjustedEnd = result.index(numberRange.upperBound, offsetBy: offset)
            let original = result[adjustedStart..<adjustedEnd]
            let replacement = "\(original).0"
            result.replaceSubrange(adjustedStart..<adjustedEnd, with: replacement)
            offset += replacement.count - original.count
        }

        return result
    }

    
    
    func formatResult(val: Double) -> String {
        return val.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", val)
        : String(format: "%.2f", val)
    }
}
