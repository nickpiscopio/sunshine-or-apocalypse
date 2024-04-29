//
//  WeatherRequest.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

enum WeatherRequest: ApiRequest {
    case fetchWeather(dto: WeatherDto)
    
    var overwrittenBaseUrl: String? {
        ""
    }
    
    var path: String {
        switch self {
        case .fetchWeather(let dto):
            return "?lat=\(dto.lat)&lon=\(dto.long)&units=\(dto.units)&appid=\(dto.appId)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .fetchWeather:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchWeather:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchWeather:
            return nil
        }
    }
}
