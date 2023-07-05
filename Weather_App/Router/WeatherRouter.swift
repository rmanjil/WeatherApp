//
//  WeatherRouter.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import Foundation


enum WeatherRouter: NetworkingRouter {
    case forecast(Parameters)
    
    
    var path: String {
        switch self {
        case .forecast:
            return "forecast/climate"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var encoder: [EncoderType] {
        switch self {
        case .forecast(let parameter):
            return [.url(parameter)]
        }
    }
}

struct None: Decodable {
    
}
