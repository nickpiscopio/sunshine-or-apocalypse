//
//  SunshineOrApocalypseTextFieldStyle.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

struct SunshineOrApocalypseTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, .dimen12)
            .padding(.horizontal, .dimen16)
            .font(Font.custom(FontName.openSansBold.rawValue, size: .font16))
            .foregroundColor(Color.sunshineOrApocalypseBlack80)
            .background(Color.sunshineOrApocalypseBlack5)
            .cornerRadius(.dimen8)
    }
}
