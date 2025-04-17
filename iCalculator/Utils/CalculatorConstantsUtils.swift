//
//  CalculatorConstantsUtils.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import SwiftUI

enum CalculatorGrids {
    static let portrait: [[String]] = [
        ["AC", "+/-", "%",  "/"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    
    static let landscape: [[String]] = [
        ["7", "8", "9", "AC", "/"],
        ["4", "5", "6", "+/-", "X"],
        ["1", "2", "3", "%", "-"],
        ["", "0", ".", "=", "+"]
    ]
}

enum CalculatorColors {
    static let operatorColor = Color.orange
    static let functionColor = Color.gray.opacity(0.5)
    static let numberColor = Color.gray.opacity(0.2)
    static let fontColor = Color.white
}

enum CalculatorButtons {
    static let operators = ["/", "+", "X", "-", "="]
    static let functions = ["AC", "⌦", "%", "+/-"]
}
