//
//  Font+extension.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

extension Text {
    func sunshineOrApocalypseTitle() -> some View {
        sunshineOrApocalypseText(fontName: .openSansBold, fontSize: .font20)
    }
    
    func sunshineOrApocalypseBody() -> some View {
        sunshineOrApocalypseText(fontName: .openSansRegular, fontSize: .font16)
    }
    
    func sunshineOrApocalypseText(fontName: FontName = FontName.openSansRegular, fontSize: CGFloat = .font14, textColor: Color = .sunshineOrApocalypseBlack80) -> some View {
        self
            .foregroundColor(textColor)
            .font(Font.custom(fontName.rawValue, size: fontSize))
    }
}
