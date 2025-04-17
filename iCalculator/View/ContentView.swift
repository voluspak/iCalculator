//
//  ContentView.swift
//  iCalculator
//
//  Created by Ivan Telleria on 16/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = CalculatorController()
    
    var body: some View {
        GeometryReader { geometry in
            if (geometry.size.width > geometry.size.height) {
                //Horizontal
                LandscapeCalculatorView(controller: controller)
            } else {
                //Vertical
                PortraitCalculatorView(controller: controller)
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
    
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
