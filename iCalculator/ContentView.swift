//
//  ContentView.swift
//  iCalculator
//
//  Created by Ivan Telleria on 16/4/25.
//

import SwiftUI

struct ContentView: View {
    let grid = [
        ["AC", "⌦", "%", "/"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    
    let operators = ["/", "+", "X", "%"]
    
    @State var visibleWorking = ""
    @State var visibleResults = ""
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(visibleWorking)
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .heavy))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                Spacer()
                Text(visibleResults)
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 50, weight: .heavy))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ForEach(grid, id: \.self){ row in
                HStack {
                    ForEach(row, id: \.self){ cell in
                        Button(action: { buttonPressed(cell)}, label: {
                            Text(cell)
                                .foregroundColor(buttonColor(cell))
                                .font(.system(size: 40, weight: .heavy))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        })
                        
                    }
                }
                
                
            }
        }
        .background(Color.black.ignoresSafeArea())
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("Invalid Input"),
                message: Text(visibleWorking),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    func buttonColor(_ cell: String) -> Color {
        if (cell == "AC" || cell == "⌦") {
            return .red
        }
        if (cell == "-" || cell == "=" || operators.contains(cell)) {
            return .orange
        }
        return .white
    }
    
    func buttonPressed(_ cell: String){
        switch cell {
        case "AC":
            visibleResults = ""
            visibleWorking = ""
        case "⌦":
            visibleWorking = String(visibleWorking.dropLast())
        case "=":
            visibleResults = calculateResults()
        case "-":
            addMinus()
        case "/", "+", "X", "%":
            addOperators(cell)
        default:
            visibleWorking += cell
        }
    }
    func addOperators(_ cell: String){
        if !visibleWorking.isEmpty {
            let last = String(visibleWorking.last!)
            if operators.contains(last) || last == "-" {
                visibleWorking.removeLast()
            }
            visibleWorking += cell
        }
    }
    func addMinus() {
        if visibleWorking.isEmpty || visibleWorking.last! != "-" {
            visibleWorking += "-"
        }
    }
    func calculateResults() -> String {
        guard validInput() else {
            showAlert = true
            return ""
        }
        
        var workings = visibleWorking.replacingOccurrences(of: "%", with: "*0.01")
        workings = workings.replacingOccurrences(of: "X", with: "*")
        
        let expression = NSExpression(format: workings)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            return formatResult(val: result)
        }
        
        showAlert = true
        return ""
    }
    func validInput() -> Bool{
        if (visibleWorking.isEmpty) {
            return false
        }
        
        guard let lastChar = visibleWorking.last else {
            return false
        }
        
        let last = String(lastChar)
        
        if (operators.contains(last) || last == "-") {
            if (last != "%" || visibleWorking.count == 1) {
                return false
            }
        }
        return true
    }
    
    func formatResult(val: Double) -> String {
        return val.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", val)
        : String(format: "%.2f", val)
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
