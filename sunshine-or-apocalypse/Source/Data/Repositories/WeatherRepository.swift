//
//  WeatherService.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Combine
import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeather(dto: WeatherDto, completionHandler: @escaping (ApiSuccess<WeatherResponse>?, ApiError?) -> Void)
}

class WeatherRepository: WeatherRepositoryProtocol {
    let networkSession: any NetworkSessionProtocol
    let endpoint = WeatherRequest.self
    
    public init(session: any NetworkSessionProtocol = NetworkSession()) {
        self.networkSession = session
    }
        
    func fetchWeather(dto: WeatherDto, completionHandler: @escaping (ApiSuccess<WeatherResponse>?, ApiError?) -> Void) {
        networkSession.request(endpoint.fetchWeather(dto: dto), completionHandler: completionHandler)
    }
}
