//
//  WeatherResponse.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

struct WeatherResponse: Codable {
    let main: MainWeather
    let weather: [WeatherDescription]
}

struct MainWeather: Codable {
    let temp: Double
}

struct WeatherDescription: Codable {
    let description: String
    let icon: String
}
