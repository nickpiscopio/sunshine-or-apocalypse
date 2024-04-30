//
//  WeatherTitleUtil.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/30/24.
//

import Foundation

enum WeatherTitleUtil {
    static func getTitle(fromTemp temp: Int, backupDescription: String) -> String {
        if temp < 0 {
            return "Apocalypse 🧊"
        }
        
        if temp > 100 {
            return "Apocalypse 🔥"
        }
        
        return backupDescription.capitalized
    }
}
