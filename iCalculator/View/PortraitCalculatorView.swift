//
//  PortraitCalculatorView.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import SwiftUI

struct PortraitCalculatorView: View {
    @ObservedObject var controller = CalculatorController()
    let grid = CalculatorGrids.portrait
    
    var body: some View {
        VStack{
            CalculatorDisplay(controller: controller)
            
            CalculatorGrid(grid: grid, controller: controller)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct PortraitCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        PortraitCalculatorView()
    }
}
