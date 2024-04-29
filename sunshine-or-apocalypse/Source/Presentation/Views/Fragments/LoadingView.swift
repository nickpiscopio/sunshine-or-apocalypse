//
//  LoadingView.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool
    @State var isAnimating: Bool = false
    
    let color: Color = .sunshineOrApocalpyseWhite100
    let size: CGFloat = 22
    let loaderThickness: CGFloat = 4
    
    var body: some View {
        if isLoading {
            Circle()
                .stroke(
                    color.opacity(0.3),
                    style: StrokeStyle(
                        lineWidth: loaderThickness,
                        lineCap: .round
                    )
                )
                .frame(width: size, height: size)
                .overlay(
                    Circle()
                        .trim(from: 0.2, to: 1)
                        .stroke(
                            color,
                            style: StrokeStyle(
                                lineWidth: loaderThickness,
                                lineCap: .round
                            )
                        )
                        .frame(width: size, height: size)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            Animation.linear(duration: 0.9)
                                .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                )
                .onAppear {
                    self.isAnimating = true
                }
        }
    }
}
