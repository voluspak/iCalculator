//
//  CalculatorDisplay.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import SwiftUI

struct CalculatorDisplay: View {
    @ObservedObject var controller: CalculatorController
    var isLandscape: Bool = false

    var body: some View {
        ScrollingTextView(
            text: controller.visibleWorking,
            font: .system(size: 30, weight: .medium),
            foregroundColor: controller.isShowingResult ? .secondary : Color.white.opacity(0),
            estimatedCharWidth: 37
        )
        .transition(.move(edge: .top).combined(with: .opacity))
        
        ScrollingTextView(
            text: controller.getActualVisible(),
            font: .system(size: 50, weight: .bold),
            foregroundColor: Color.white,
            estimatedCharWidth: 37
        )
        
    }

}
