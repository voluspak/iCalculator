//
//  CalculatorController.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import Foundation
import SwiftUI

class CalculatorController: ObservableObject {
    @Published var visibleWorking: String = ""
    @Published var visibleResults: String = ""
    @Published var showAlert: Bool = false
    @Published var isShowingResult: Bool = false
    

    private func setShowingResult(_ value: Bool) -> Void {
        isShowingResult = value
    }
    
    private var model = CalculatorModel()
    
    var clearButtonLabel: String {
        if !visibleResults.isEmpty || visibleWorking.isEmpty {
            return "AC"
        }
        return "⌦"
    }

    func buttonPressed(_ cell: String){
        if !visibleResults.isEmpty && cell != "=" {
            setShowingResult(false)
            visibleWorking = ""
            visibleResults = ""
        }
        
        switch cell {
        case "AC", "⌦":
            if clearButtonLabel == "AC" {
                visibleResults = ""
                visibleWorking = ""
            } else {
                visibleWorking = String(visibleWorking.dropLast())
            }
        case "=":
            calculateResults()
            setShowingResult(true)
        case "-":
            addMinus()
        case "/", "+", "X", "%":
            addOperators(cell)
        case "+/-":
            toggleSign()
        default:
            visibleWorking += cell
        }
    }
    
    func toggleSign() {
        guard !visibleWorking.isEmpty else { return }

        let pattern = #"(\(-?\d+\.?\d*\)|-?\d+\.?\d*)$"#
        if let range = visibleWorking.range(of: pattern, options: .regularExpression) {
            let numberString = String(visibleWorking[range])

            // Detectar si ya tiene paréntesis
            if numberString.hasPrefix("(-") && numberString.hasSuffix(")") {
                // Remover paréntesis y el signo negativo
                let cleaned = numberString
                    .replacingOccurrences(of: "(-", with: "")
                    .replacingOccurrences(of: ")", with: "")
                visibleWorking.replaceSubrange(range, with: cleaned)
            } else {
                // Convertirlo en negativo con paréntesis
                let toggled = "(-\(numberString))"
                visibleWorking.replaceSubrange(range, with: toggled)
            }
        }
    }
    
    func calculateResults() -> Void {
        guard model.validInput(visibleWorking) else {
            showAlert = true
            return
        }
        
        if let result = model.calculateResults(visibleWorking) {
            visibleResults = model.formatResult(val: result)
        } else {
            showAlert = true
        }
    }
    
    func addOperators(_ cell: String){
        guard !visibleWorking.isEmpty else { return }
        let last = String(visibleWorking.last!)

        if model.operators.contains(last) || last == "-" {
            visibleWorking.removeLast()
        }
        
        visibleWorking += cell
        
    }
    
    func addMinus() {
        if visibleWorking.isEmpty || visibleWorking.last! != "-" {
            visibleWorking += "-"
        }
    }
    
    func getActualVisible() -> String {
        return visibleResults.isEmpty
        ? visibleWorking
        : visibleResults
        
    }
}
