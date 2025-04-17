//
//  CalculatorController.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import Foundation
import SwiftUI

class CalculatorController: ObservableObject {
    @Published var visibleWorking = ""
    @Published var visibleResults = ""
    @Published var showAlert = false
    
    private var model = CalculatorModel()
    
    func buttonPressed(_ cell: String){
        switch cell {
        case "AC":
            visibleResults = ""
            visibleWorking = ""
        case "⌦":
            visibleWorking = String(visibleWorking.dropLast())
        case "=":
            calculateResults()
        case "-":
            addMinus()
        case "/", "+", "X", "%":
            addOperators(cell)
        default:
            visibleWorking += cell
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
}
