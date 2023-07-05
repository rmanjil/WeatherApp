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
    
}
