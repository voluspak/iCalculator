//
//  LandscapeCalculatorView.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import SwiftUI

struct LandscapeCalculatorView: View {
    @ObservedObject var controller = CalculatorController()

    let grid = CalculatorGrids.landscape

    var body: some View {
        VStack {
            CalculatorDisplay(controller: controller, isLandscape: true)
                .padding()
                .frame(height: 50)
            
            VStack{
                CalculatorGrid(grid: grid, controller: controller, isLandscape: true)
            }
            
        }
        .padding()
        .background(Color.black.ignoresSafeArea())

        }
}

struct LandscapeCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        LandscapeCalculatorView()
    }
}
