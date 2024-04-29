//
//  WatherResultsState.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

class WeatherResultsState {
    private var weather: Weather? = nil
    
    func setState(weather: Weather?) {
        self.weather = weather
    }
    
    func getState() -> Weather? {
        return weather
    }
}
