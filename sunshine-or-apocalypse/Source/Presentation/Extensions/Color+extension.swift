//
//  Color+extension.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

enum SunshineOrApocalypseColor: String {
    case sunshineOrApocalypseBlack5 = "black5"
    case sunshineOrApocalypseBlack50 = "black50"
    case sunshineOrApocalypseBlack80 = "black80"
    case sunshineOrApocalypseBlue100 = "blue100"
    case sunshineOrApocalypseWhite100 = "white100"
}

extension Color {
    static var sunshineOrApocalypseBlack5: Color { Color(SunshineOrApocalypseColor.sunshineOrApocalypseBlack5.rawValue) }
    static var sunshineOrApocalypseBlack50: Color { Color(SunshineOrApocalypseColor.sunshineOrApocalypseBlack50.rawValue) }
    static var sunshineOrApocalypseBlack80: Color { Color(SunshineOrApocalypseColor.sunshineOrApocalypseBlack80.rawValue) }
    static var sunshineOrApocalpyseBlue100: Color { Color(SunshineOrApocalypseColor.sunshineOrApocalypseBlue100.rawValue) }
    static var sunshineOrApocalpyseWhite100: Color { Color(SunshineOrApocalypseColor.sunshineOrApocalypseWhite100.rawValue) }
}
