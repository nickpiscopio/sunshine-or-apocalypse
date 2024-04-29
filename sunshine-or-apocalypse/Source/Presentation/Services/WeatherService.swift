//
//  WeatehrService.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(dto: WeatherDto, completionHandler: @escaping (ApiSuccess<WeatherResponse>?, ApiError?) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    var repo: WeatherRepository
    init(repo: WeatherRepository) {
        self.repo = repo
    }
    
    func fetchWeather(dto: WeatherDto, completionHandler: @escaping (ApiSuccess<WeatherResponse>?, ApiError?) -> Void) {
        repo.fetchWeather(dto: dto, completionHandler: completionHandler)
    }
}

