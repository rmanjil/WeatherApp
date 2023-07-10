//
//  WeatherManager.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import Foundation

func addApiKey(parameter: Parameters) -> Parameters {
    var parameter = parameter
    if let key = Networking.default.apiKey {
        parameter["appid"] = key
    }
    return parameter
}

class WeatherManager {
    let networking = Networking.default
    
    
    func fetchCurrentWeather(parameter: Parameters) async throws -> WeatherData {
        let parameter = addApiKey(parameter: parameter)
        return try await networking.dataRequest(router: WeatherRouter.weather(parameter), type: WeatherData.self)
    }
    
    func fetchForecast(parameter: Parameters) async throws -> WeatherResponse {
        let parameter = addApiKey(parameter: parameter)
       return try await networking.dataRequest(router: WeatherRouter.forecast(parameter), type: WeatherResponse.self)
    }
}
