import SwiftUI

struct CalculatorGrid: View {
    let grid: [[String]]
    @ObservedObject var controller: CalculatorController
    var isLandscape: Bool = false
    
    var body: some View {
        ForEach(grid, id: \.self){ row in
            HStack {
                ForEach(row, id: \.self){ cell in
                    Button(action: { controller.buttonPressed(cell)}, label: {
                        Text(cell == "AC" || cell == "⌦" ? controller.clearButtonLabel : cell)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: isLandscape ? 50 : .infinity)
                    })
                    .background(buttonColor(cell))
                    .cornerRadius(isLandscape ? 15 : .greatestFiniteMagnitude)
                    
                }
            }
        }
    }
}
    func buttonColor(_ cell: String) -> Color {
        if CalculatorButtons.functions.contains(cell) {
            return CalculatorColors.functionColor        }
        if cell == "%" || CalculatorButtons.operators.contains(cell) {
            return CalculatorColors.operatorColor
        }
        return CalculatorColors.numberColor
    }

