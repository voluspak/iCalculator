//
//  ScrollingTextView.swift
//  iCalculator
//
//  Created by Ivan Telleria on 17/4/25.
//

import SwiftUI

struct ScrollingTextView: View {
    let text: String
    let font: Font
    let foregroundColor: Color
    var estimatedCharWidth: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let maxChars = Int(geometry.size.width / estimatedCharWidth)
            
            Group {
                if (text.count > maxChars) {
                    ScrollViewReader{ proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                Spacer()
                                Text(text)
                                    .font(font)
                                    .foregroundColor(foregroundColor)
                                    .lineLimit(1)
                                Color.clear.frame(width: 1, height: 1).id("end")
                            }
                        }
                        .onChange(of: text){ _ in
                            proxy.scrollTo("end", anchor: .trailing)
                        }
                    }
                } else {
                    HStack{
                        Spacer()
                        Text(text)
                            .font(font)
                            .foregroundColor(foregroundColor)
                            .lineLimit(1)
                    }
                }
            }
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

