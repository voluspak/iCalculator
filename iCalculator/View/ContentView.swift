//
//  ContentView.swift
//  iCalculator
//
//  Created by Ivan Telleria on 16/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = CalculatorController()
    
    let grid = [
        ["AC", "⌦", "%", "/"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(controller.visibleWorking)
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .heavy))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                Spacer()
                Text(controller.visibleResults)
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 50, weight: .heavy))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ForEach(grid, id: \.self){ row in
                HStack {
                    ForEach(row, id: \.self){ cell in
                        Button(action: { controller.buttonPressed(cell)}, label: {
                            Text(cell)
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        })
                        .background(buttonColor(cell))
                        .clipShape(Circle())
                        
                    }
                }
                
                
            }
        }
        .background(Color.black.ignoresSafeArea())
        .alert(isPresented: $controller.showAlert){
            Alert(
                title: Text("Invalid Input"),
                message: Text(controller.visibleWorking),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    func buttonColor(_ cell: String) -> Color {
        let ops = ["/", "+", "X", "%"]
        
        if (cell == "AC" || cell == "⌦" || cell == "%") {
            return .gray.opacity(0.5)
        }
        if (cell == "-" || cell == "=" || ops.contains(cell)) {
            return .orange
        }
        return .gray.opacity(0.2)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
