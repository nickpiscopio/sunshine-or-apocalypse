//
//  PrimaryButton.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

struct PrimaryButton: View {
    let buttonText: String
    var cornerRadius: CGFloat = .dimen8
    var corners: UIRectCorner = .allCorners
    var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                LoadingView(isLoading: .constant(true))
            } else {
                Text(buttonText)
                    .sunshineOrApocalypseText(fontName: .openSansBold, fontSize: .dimen16, textColor: Color.sunshineOrApocalpyseWhite100)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.dimen16)
        .background(
            Rectangle()
                .fill(Color.sunshineOrApocalpyseBlue100)
                .cornerRadius(cornerRadius)
        )
    }
}
