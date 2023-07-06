//
//  WeatherRouter.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import Foundation

enum WeatherRouter: NetworkingRouter {
    case forecast(Parameters)
    case weather(Parameters)
    
    
    var path: String {
        switch self {
        case .weather:
            return "2.5/weather"
        case .forecast:
            return "2.5/forecast/climate"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var encoder: [EncoderType] {
        switch self {
        case .forecast(let parameter), .weather(let parameter):
            return [.url(parameter)]
        }
    }
}

struct None: Decodable {
    
}
